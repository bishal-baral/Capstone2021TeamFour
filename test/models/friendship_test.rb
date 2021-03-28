require "test_helper"

class FriendshipTest < ActiveSupport::TestCase
  def setup
    @friend = Friendship.new(sent_to_id: 216, 
                             sent_by_id: 218,
                             status: true)
  end

  test "should be valid" do
    assert @friend.valid?
  end

  test "friend should have sender" do
    @friend.sent_to_id = nil
    assert_not @friend.valid?
    @friend.sent_to_id = -1
    assert_not @friend.valid?
  end

  test "friend should have receiver" do
    @friend.sent_by_id = nil
    assert_not @friend.valid?
    @friend.sent_by_id = -1
    assert_not @friend.valid?
  end

  test "friend and user should not match" do
    @friend.sent_to_id = @friend.sent_by_id
    assert_not @friend.valid?
  end

end
