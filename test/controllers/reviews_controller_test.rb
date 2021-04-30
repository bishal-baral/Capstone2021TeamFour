# frozen_string_literal: true

require 'test_helper'

class ReviewsControllerTest < ActionDispatch::IntegrationTest
  include ReviewsHelper
  setup do
    # Auth tests are handled by another controller's test.
    log_in('tamela@braun.biz', 'G4qScZ5m13OvS2h7B')
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

  # Basic review creation tests
  test 'can access review creation' do
    get '/create_review', xhr: true
    assert_response :success
  end

  test 'can create basic review' do
    post reviews_path, params: { review: { media: @media,
                                           content: @content,
                                           recommended: @rec } }
    assert_redirected_to profile_path
  end

  test 'should be associated with posting user' do
    post reviews_path, params: { review: { media: @media,
                                           content: @content,
                                           recommended: @rec } }
    assert_not_nil Review.find_by(user_id: @user_id, media: @media)
  end

  test 'requires valid media' do
    post reviews_path, params: { review: { content: @content,
                                           ecommended: @rec } }
    assert_redirected_to home_path
  end

  test 'requires valid content' do
    post reviews_path, params: { review: { media: @media,
                                           recommended: @rec } }
    assert_redirected_to home_path
  end

  test 'allows missing recommended bool' do
    post reviews_path, params: { review: { media: @media,
                                           content: @content } }
    assert_not Review.find_by(user_id: @user_id, media: @media).recommended
  end

  test 'posting review generates time stamp of ~now' do
    post reviews_path, params: { review: { media: @media,
                                           content: @content,
                                           recommended: @rec } }
    assert Review.find_by(user_id: @user_id, media: @media).post_date > Time.now - 60
  end

  # Tag related review tests
  test 'can add a valid tag to review' do
    post reviews_path, params: { review: { media: @media,
                                           content: @content,
                                           recommended: @rec,
                                           tag_1_category: @cat_one,
                                           tag_1_name: @name_one } }
    rev = Review.find_by(user_id: @user_id, media: @media)
    assert_not_nil rev.tags.find_by(category: @cat_one, name: @name_one)
  end

  test 'can add multiple tags to a single review' do
    post reviews_path, params: { review: { media: @media,
                                           content: @content,
                                           recommended: @rec,
                                           tag_1_category: @cat_one,
                                           tag_1_name: @name_one,
                                           tag_2_category: @cat_two,
                                           tag_2_name: @name_two } }
    rev = Review.find_by(user_id: @user_id, media: @media)
    assert_not_nil rev.tags.find_by(category: @cat_one, name: @name_one)
    assert_not_nil rev.tags.find_by(category: @cat_two, name: @name_two)
  end

  test 'review should be posted even if tag is invalid' do
    post reviews_path, params: { review: { media: @media,
                                           content: @content,
                                           recommended: @rec,
                                           tag_1_category: '',
                                           tag_1_name: 'X Men' * 60 } }
    assert_not_nil Review.find_by(user_id: @user_id, media: @media)
  end

  test 'should be able to add individual tags to reviews' do
    rev = Review.find_by(id: 545)
    post '/add_tag/545', params: { tag: { category: @cat_one, name: @name_one } }
    assert ReviewTag.where(review_id: rev.id).length, 1
  end

  test 'should not be able to duplicate tags' do
    tag = Tag.create(category: @cat_one, name: @name_one)
    rev = Review.find_by(id: 545)
    ReviewTag.create(review_id: rev.id, tag_id: tag.id)
    post '/add_tag/545', params: { tag: { category: @cat_one, name: @name_one } }
    assert ReviewTag.where(review_id: rev.id, tag_id: tag.id).length, 1
  end
end
