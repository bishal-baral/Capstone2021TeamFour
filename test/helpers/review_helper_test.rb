# frozen_string_literal: true

require 'test_helper'

class ReviewsControllerTest < ActionDispatch::IntegrationTest
  include ReviewsHelper
  setup do
    @user_id = 216
    @review = Review.new
    @media = 'Logan'
    @content = 'Best movie about a man and a girl'
    @rec = true
    @cat_one = 'Series'
    @name_one = 'X men'
    @cat_two = 'Lead actor'
    @name_two = 'Hugh jackman'
  end

  # Valid_tag tests
  test 'basic tag should be valid' do
    assert valid_tag @cat_one, @name_one
  end

  test 'empty tags should be invalid' do
    assert_not valid_tag @cat_one, ''
    assert_not valid_tag '', @name_one
    assert_not valid_tag '', nil
  end

  test 'tags with long categories or names should be invalid' do
    assert_not valid_tag @cat_two * 50, @name_two
    assert_not valid_tag @cat_two, @name_two * 30
  end

  # Collect_tags tests
  test 'should create a hash of category name pairings from params' do
    fake_params = {
      tag_1_category: @cat_one,
      tag_1_name: @name_one,
      tag_2_category: @cat_two,
      tag_2_name: @name_two
    }
    tags_hash = collect_tags fake_params
    assert_equal tags_hash[@cat_one], @name_one
    assert_equal tags_hash[@cat_two], @name_two
  end

  test 'should create hash even if first pair invalid' do
    fake_params = {
      tag_1_category: @cat_one,
      tag_1_name: '',
      tag_2_category: @cat_two,
      tag_2_name: @name_two
    }
    tags_hash = collect_tags fake_params
    assert_nil tags_hash[@cat_one]
    assert_equal tags_hash[@cat_two], @name_two
  end

  # Grab_tag tests
  test 'should create a new tag' do
    grab_tag @cat_one, @name_one
    assert_equal Tag.find_by(category: @cat_one).name, @name_one
  end

  test 'should return but not create if tag pre-existing' do
    Tag.create(category: @cat_one, name: @name_one)
    tag = grab_tag @cat_one, @name_one
    assert_equal Tag.where(category: @cat_one, name: @name_one).length, 1
    assert_equal Tag.find_by(category: @cat_one, name: @name_one).id, tag.id
  end

  # Create_tags tests
  test 'should create and associate a tag' do
    rev = Review.create(media: @media, content: @content, recommended: @rec, user_id: 216)
    fake_params = { @cat_one => @name_one }
    create_tags(fake_params, rev.id)
    tag = Tag.find_by(category: @cat_one, name: @name_one)
    assert ReviewTag.find_by(review_id: rev.id, tag_id: tag.id)
  end

  test 'should associate with tags that already exist' do
    Tag.create(category: @cat_one, name: @name_one)
    rev = Review.create(media: @media, content: @content, recommended: @rec, user_id: 216)
    fake_params = { @cat_one => @name_one }
    create_tags(fake_params, rev.id)
    assert ReviewTag.where(review_id: rev.id).length, 1
  end
end
