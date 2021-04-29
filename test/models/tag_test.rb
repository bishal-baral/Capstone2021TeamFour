# frozen_string_literal: true

require 'test_helper'

class TagTest < ActiveSupport::TestCase
  def setup
    @tag = Tag.new(category: 'Medium',
                   name: 'YouTube Video')
  end

  test 'tag should be valid' do
    assert @tag.valid?
  end

  test 'category defaults to other' do
    t = Tag.new(name: 'Twitch streamer')
    assert t.valid?
  end

  test 'name should be required' do
    @tag.name = nil
    assert_not @tag.valid?
  end

  test 'should be case insensitive' do
    tag_two = Tag.create(category: 'MeDiUm', name: 'YOUTUBE video')
    assert_equal tag_two.category, @tag.category
  end

  test 'category length should be limited' do
    @tag.category = 'foo' * 20
    assert_not @tag.valid?
  end

  test 'name length should be limited' do
    @tag.name = 'bar' * 20
    assert_not @tag.valid?
  end
end
