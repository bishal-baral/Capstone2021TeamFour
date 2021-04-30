# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include UsersHelper

  def setup
    @username = 'Dorsey'
    @email = 'jefferey@mills-anderson.info'
    @pw = 'P04gX7eAiG3fXjJ322'
    @other_user = User.first
  end

  # User helper tests
  test 'helper code_gen should work' do
    assert_not_nil gen_code(@other_user)
  end

  test 'helper tags_from_string should work' do
    tag_string = 'title:Hacksaw-Ridge genre:action'
    target = { 'title' => 'Hacksaw Ridge', 'genre' => 'action' }
    assert_equal target, tags_from_string(tag_string)
  end

  test 'helper filter_reviews should work ' do
    reviews = [Review.find_by(id: 545), Review.find_by(id: 548)]
    result = filter_reviews(reviews, tags_from_string('title:hacksaw-ridge'))
    assert_equal result, [Review.find_by(id: 548)]
  end

  # Signup tests
  test 'should get new' do
    get signup_path
    assert_response :success
  end

  test 'should be able to sign up' do
    post signup_path, params: { user: { username: @username,
                                        email: @email,
                                        password: @pw,
                                        password_confirmation: @pw } }
    @user = User.find_by(username: @username)
    assert_not_nil @user
    assert_equal session[:user_id], @user.id
  end

  test 'don\'t sign up if passwords missmatch' do
    post signup_path, params: { user: { username: @username,
                                        email: @email,
                                        password: 'foobarbaz',
                                        password_confirmation: @pw } }
    assert_nil User.find_by(username: @username)
  end

  test 'don\'t sign up if email already exists' do
    post signup_path, params: { user: { username: @username,
                                        email: @other_user.email,
                                        password: @pw,
                                        password_confirmation: @pw } }
    assert_nil User.find_by(username: @username)
  end

  # Profile tests
  test 'should show user profile' do
    post signup_path, params: { user: { username: @username,
                                        email: @email,
                                        password: @pw,
                                        password_confirmation: @pw } }
    @user = User.find_by(username: @username)
    get profile_path
    assert_response :success
  end

  # Profile, friend_profile, and search tests
  test 'don\'t show unauthorized user profile or show' do
    get profile_path
    assert_redirected_to root_path
    get home_path
    assert_redirected_to root_path
  end

  test 'don\'t show logged in users the signup screen' do
    log_in('tamela@braun.biz', 'G4qScZ5m13OvS2h7B')
    get signup_path
    assert_redirected_to profile_path
  end

  test 'can get friend\'s profiles' do
    log_in('tamela@braun.biz', 'G4qScZ5m13OvS2h7B')
    post friend_profile_path, params: { user_id: 217 }
    assert_response :success
  end

  test 'can\'t get non-friend\'s profiles' do
    log_in('tamela@braun.biz', 'G4qScZ5m13OvS2h7B')
    post friend_profile_path, params: { user_id: 218 }
    assert_redirected_to profile_path
  end
end
