class ReviewsController < ApplicationController

  def show
    @review = Review.find
  end

  def new
    @review = Review.new
  end

  def create
    
    @review = Review.new(review_params)
    # add something about session's user here
    @review.user_id = User.all.sample.id

    # Add who on friend list to send to
    if @review.save
      redirect_to '/'
    else
      render 'new'
    end
  end

  private 

    def review_params
      params.require(:review).permit(:user, :media, :content, :recommended)
    end
end
