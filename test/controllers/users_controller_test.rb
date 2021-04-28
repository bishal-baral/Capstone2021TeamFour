require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @username = "Dorsey"
    @email = "jefferey@mills-anderson.info"
    @pw = "P04gX7eAiG3fXjJ322"
    @other_user = User.first
  end

  # test "should get new" do
  #   get '/signup'
  #   assert_response :success
  # end

  # test "should be able to sign up" do
  #   post '/signup', params: { user: { username: @username,
  #                                     email: @email,
  #                                     password: @pw,
  #                                     password_confirmation: @pw } }
  #   @user = User.find_by(username: @username)
  #   assert_not_nil @user
  #   assert_equal session[:user_id], @user.id
  # end
    
  # test "don't sign up if passwords missmatch" do
  #   post '/signup', params: { user: { username: @username,
  #                                     email: @email,
  #                                     password: "foobarbaz",
  #                                     password_confirmation: @pw } }
  #   assert_nil User.find_by(username: @username)
  # end

  # test "don't sign up if email already exists" do
  #   post '/signup', params: { user: { username: @username,
  #                                     email: @other_user.email,
  #                                     password: @pw,
  #                                     password_confirmation: @pw } }
  #   assert_nil User.find_by(username: @username)
  # end

  # test "should show user profile" do
  #   post '/signup', params: { user: { username: @username,
  #                                     email: @email,
  #                                     password: @pw,
  #                                     password_confirmation: @pw } }
  #   @user = User.find_by(username: @username)
  #   get "/users/#{@user.id}"
  #   assert_response :success
  # end
end
