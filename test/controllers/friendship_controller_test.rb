require "test_helper"

class FriendshipControllerTest < ActionDispatch::IntegrationTest
  setup do
    # Auth tests are handled by another controller's test.
    log_in('tamela@braun.biz', 'G4qScZ5m13OvS2h7B')
    @user_id = 216
    @friend_id = 217
    @other_id = 218
  end

  # Initial friendship page tests
  test 'can access friendship page' do
    get friendship_path
    assert_response :success
  end

  test 'can see friends' do
    get friendship_path
    assert_select 'a', 'Liliana #5174'
  end

  # Search results test
  test 'can search for users' do
    get '/result', xhr: true, params: { username: 'Russel', code: 3794 }
    assert_response :success
  end

  # Send friend request tests
  test 'can send friend requests to other users' do
    post friendship_path, params: { user_id: @other_id }
    assert_redirected_to friendship_path
    assert_not_nil Friendship.find_by(sent_to_id: @other_id, sent_by_id: @user_id)
    assert_equal 'Friend request sent!', flash[:success]
  end

  # This block of tests also handles all the cases of the one helper function
  test 'cannot send request to self' do
    post friendship_path, params: { user_id: @user_id }
    assert_equal 'You can\'t send a request to yourself', flash[:warning]
  end

  test 'cannot duplicate requests' do
    post friendship_path, params: { user_id: @other_id }
    post friendship_path, params: { user_id: @other_id }
    assert_equal 'You can\'t send a request twice', flash[:warning]
  end

  test 'cannot send requests to friends' do
    post friendship_path, params: { user_id: @friend_id }
    assert_equal 'You are already friends with this user', flash[:warning]
  end

  test 'cannot send requests to user that has requested you' do
    post friendship_path, params: { user_id: @other_id }
    log_out
    log_in('timmy.kerluke@botsford.net', 'Eu6T0iOb6ZsB3jUbCyC0')
    post friendship_path, params: { user_id: @user_id }
    assert_equal 'You already have a request from this user', flash[:warning]
  end

  # Accept friend tests
  test 'can accept friend request' do
    post friendship_path, params: { user_id: @other_id }
    log_out
    log_in('timmy.kerluke@botsford.net', 'Eu6T0iOb6ZsB3jUbCyC0')
    put friendship_path, params: { user_id: @user_id }
    assert_redirected_to friendship_path
    assert_equal 'Friend request accepted!', flash[:success]
    assert Friendship.find_by(sent_by_id: @user_id, sent_to_id: @other_id).status
    assert Friendship.find_by(sent_by_id: @other_id, sent_to_id: @user_id).status
  end

  test 'can\'t accept non-existenct friendship' do
    put friendship_path, params: { user_id: @other_id }
    assert_redirected_to friendship_path
    assert_equal 'Friend request does not exist', flash[:warning]
  end

  # Decline friend tests
  test 'can decline friend request' do
    post friendship_path, params: { user_id: @other_id }
    log_out
    log_in('timmy.kerluke@botsford.net', 'Eu6T0iOb6ZsB3jUbCyC0')
    delete friendship_path, params: { user_id: @user_id }
    assert_redirected_to friendship_path
    assert_equal 'Friend request declined!', flash[:success]
    assert_nil Friendship.find_by(sent_by_id: @user_id, sent_to_id: @other_id)
  end

  test 'can\'t decline non-existenct friendship' do
    delete friendship_path, params: { user_id: @other_id }
    assert_redirected_to friendship_path
    assert_equal 'Friend request does not exist', flash[:warning]
  end
end
