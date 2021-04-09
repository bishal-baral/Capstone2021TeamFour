require "test_helper"

class ReviewTagTest < ActiveSupport::TestCase
  def setup
    @rt = ReviewTag.new(review_id: 545, tag_id: 1)
  end

  test "review tag should be valid" do
    assert @rt.valid?
  end

  test "review tag needs review" do
    @rt.review_id = 0
    assert_not @rt.valid?
  end

  test "review tag needs tag" do
    @rt.tag_id = 0
    assert_not @rt.valid?
  end
end
