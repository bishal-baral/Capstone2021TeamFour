require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @pw_one = "G4qScZ5m13OvS2h7B"
    @user_one = User.find_by(id: 216)
    @pw_two = "2CeMh360U4kD18wBh"
    @user_two = User.find_by(id: 217)
  end
  
  test "should get new" do
    get sessions_new_path
    assert_response :success
  end

  test "should authenticate user" do
    post '/login', params: { session: { email: @user_one.email, 
                                        password: @pw_one } }
    assert_redirected_to @user_one
    assert session[:user_id] == 216
  end

  test "should log in and log out user" do
    post '/login', params: { session: { email: @user_two.email, 
                                        password: @pw_two } }
    assert_redirected_to @user_two
    assert_equal session[:user_id], 217

    delete '/logout'
    assert_redirected_to root_path
    assert session[:user_id].nil?
  end

  test "should return to login page on bad credentials" do
    post '/login', params: { session: { email: @user_two.email, 
                                        password: @pw_one } }
    assert_equal "Invalid email/password combo", flash[:danger]
    assert session[:user_id].nil?
  end
    
end
