# frozen_string_literal: true

require 'test_helper'

class ReviewTest < ActiveSupport::TestCase
  def setup
    @review = Review.new(media: 'PewDiePie',
                         content: 'He is Youtuber',
                         user_id: User.first.id,
                         recommended: false)
  end

  test 'review should be valid' do
    assert @review.valid?
  end

  test 'review should have user' do
    @review.user_id = 1
    assert_not @review.valid?
  end

  test 'review should have media title' do
    @review.media = nil
    assert_not @review.valid?
  end

  test 'review should have content' do
    @review.content = nil
    assert_not @review.valid?
  end

  test 'cap media and content lengths title length' do
    @review.media = 'foo' * 100
    assert_not @review.valid?
    @review.content = 'bad thing' * 1000
    assert_not @review.valid?
  end
end
