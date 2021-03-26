require "test_helper"

class FriendTest < ActiveSupport::TestCase

  def setup
    @friend = Friend.new(user_id: 216, friend_id: 217)
  end

  test "should be valid" do
    assert @friend.valid?
  end

  test "friend should have user" do
    @friend.user_id = nil
    assert_not @friend.valid?
    @friend.user_id = 3
    assert_not @friend.valid?
  end

  test "friend should have friend" do
    @friend.friend_id = nil
    assert_not @friend.valid?
    @friend.friend_id = 3
    assert_not @friend.valid?
  end

  test "friend and user should not match" do
    @friend.friend_id = @friend.user_id
    assert_not @friend.valid?
  end

end
