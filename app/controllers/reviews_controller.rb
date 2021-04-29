class ReviewsController < ApplicationController
  include ReviewsHelper
  # GET New action.
  def new
    @review = Review.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST Reviews action. Creates a review from valid params
  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    @review.post_date = Time.zone.now

    if @review.save
      # Create notifications for the user's friends
      current_user.friends.each do |friend|
        Notification.create(recipient: friend, actor: current_user, action: 'posted', notifiable: @review)
      end

      # Create and attach the tags
      create_tags collect_tags(params[:review]), @review.id
      redirect_to '/profile'
    else
      redirect_to '/home'
    end
  end

  # GET Add tag :id action. Set up for the next action
  def tag
    @review = Review.find_by(id: params[:id])
    @tag = Tag.new
  end

  # POST Add tag :id action. Allows review tag association after review creation
  def add_tag
    @review = Review.find_by(id: params[:id])
    tag_cat = params[:tag][:category]
    tag_name = params[:tag][:name]

    if valid_tag(tag_cat, tag_name)
      @tag = grab_tag(tag_cat, tag_name)
      if ReviewTag.find_by(tag_id: @tag.id, review_id: @review.id).nil?
        ReviewTag.create(tag_id: @tag.id, review_id: @review.id)
      end
    end
    redirect_to '/profile'
  end

  private

  def review_params
    params.require(:review).permit(:media, :content, :recommended, :cover)
  end
end
