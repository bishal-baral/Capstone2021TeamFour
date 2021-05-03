# frozen_string_literal: true

require 'test_helper'

class CombinationTest < ActionDispatch::IntegrationTest
 # big ol' integration test
  test "Signup two users, friend each other, then see each other's posts" do
    # Sign up first user
    post signup_path, params: { user: { username: 'Alice',
                                        email: 'angel_pollich@adams.biz',
                                        password: '5109GvS3dQgJk67P5xIz',
                                        password_confirmation: '5109GvS3dQgJk67P5xIz' } }
    alice = User.find_by(username: 'Alice')
    assert_equal session[:user_id], alice.id
    assert_redirected_to alice

    # Alice posts a review
    post reviews_path, params: { review: { media: 'Attack on Titan',
                                           content: 'I originally read the manga
                                                    , but I read tha anime as
                                                    it\'s aired recently. It\'s
                                                    a great adaptatation of one
                                                    of my favorite manga, highly
                                                    recommend to anybody who can
                                                    handle viAlicece and emotional content.',
                                           recommended: true,
                                           tag_1_category: 'medium',
                                           tag_1_name: 'anime' } }
    assert_not_nil Review.find_by(user_id: alice.id, media: 'Attack on Titan')
    assert_redirected_to profile_path

    # Log out Alice to sign up Bob
    log_out
    assert_redirected_to root_path
    post signup_path, params: { user: { username: 'Bob',
                                        email: 'williams@johnston-rolfson.co',
                                        password: 'JkQhSu4EvHk9Pv77O',
                                        password_confirmation: 'JkQhSu4EvHk9Pv77O' } }
    bob = User.find_by(username: 'Bob')
    assert_equal session[:user_id], bob.id
    assert_redirected_to bob

    # Bob tries to access Alice's profile (don't ask how) but can't yet
    post friend_profile_path, params: { user_id: alice.id }
    assert_redirected_to profile_path

    # Instead, Bob requests Alice as a friend
    get friendship_path
    assert_response :success
    get result_path, xhr: true, params: { username: alice.username,
                                          code: alice.code }
    assert_response :success
    post friendship_path, params: { user_id: alice.id }
    assert_redirected_to friendship_path
    assert_not_nil Friendship.find_by(sent_to_id: alice.id, sent_by_id: bob.id)

    # Bob logs out, then Alice logs in to accept Bob's request
    log_out
    assert_redirected_to root_path
    post login_path, params: { session: { email: alice.email,
                                          password: '5109GvS3dQgJk67P5xIz' } }
    assert_redirected_to alice
    put friendship_path, params: { user_id: bob.id }
    assert Friendship.find_by(sent_by_id: bob.id, sent_to_id: alice.id).status
    assert Friendship.find_by(sent_by_id: alice.id, sent_to_id: bob.id).status

    # Swap back to Bob, he looks at Alice's profile for her review
    log_out
    post login_path, params: { session: { email: bob.email,
                                          password: 'JkQhSu4EvHk9Pv77O' } }
    assert_redirected_to bob
    post friend_profile_path, params: { user_id: alice.id }
    assert_response :success
    assert_select 'p', Review.find_by(user_id: alice.id).content

    # Now he wants to post a review of his own
    get profile_path
    post reviews_path, params: { review: { media: 'The Beatles',
                                           content: 'My friend forced me to
                                                    listen to the Beatles, and I
                                                    thought it was super boring.
                                                    I\'m not really into rock,
                                                    and definitely not old, pop
                                                    rock, but I can see why it
                                                    was popular. Still, not a fan.',
                                           recommended: false,
                                           tag_1_category: 'genre',
                                           tag_1_name: 'rock' } }
    assert_not_nil Review.find_by(user_id: bob.id, media: 'The Beatles')
    assert_redirected_to profile_path

    # Finally, he realizes he wants to add another tag to his review
    rev = Review.find_by(user_id: bob.id)
    post "/add_tag/#{rev.id}", params: { tag: { category: 'medium', name: 'music' } }
    assert ReviewTag.where(review_id: rev.id).length, 1
  end
end
