require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(username: "john doe",
                     email: "keira@lubowitz.info",
                     code: 6853,
                     password: "Cr3Zr6Nv57EcIfK")
  end

  test "user should be valid" do
    assert @user.valid?
  end

  test "user should have short username" do
    @user.username = nil
    assert_not @user.valid?
    @user.username = "fifty" * 10
    assert_not @user.valid?
  end

  test "user should have unique email" do
    @user.email = nil
    assert_not @user.valid?
    @user.email = "tamela@braun.biz"
    assert_not @user.valid?
  end

  test "user email should not be junk" do
    @user.email = "bar" * 150 + "@gmail.com"
    assert_not @user.valid?
    @user.email = "kappakappakpog"
    assert_not @user.valid?
  end

  test "user should have password" do 
    @user.password_digest = nil
    assert_not @user.valid?
  end

  test "user should have four integer friend code" do
    @user.code = nil
    assert_not @user.valid?
    @user.code = 55555
    assert_not @user.valid?
    @user.code = 22
    assert_not @user.valid?
  end

  test "user should be unique by username and code" do
    @user.username = User.first.username
    @user.code = User.first.code
    assert_raises ActiveRecord::RecordNotUnique do
      @user.save
    end
  end
end
