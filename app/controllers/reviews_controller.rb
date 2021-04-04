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
    @review.user_id = current_user.id
    tag_cat = params[:review][:tag_category]
    tag_name = params[:review][:tag_name]

    # Add who on friend list to send to
    if !valid_tag(tag_cat, tag_name)
      render 'new'
    elsif @review.save
      if tag_name != ""
        @tag = grab_tag(tag_cat, tag_name)
        ReviewTag.create(tag_id: @tag.id, review_id: @review.id)
      end
      redirect_to '/profile'
    else
      render 'new'
    end
  end

  private 

    def review_params
      params.require(:review).permit(:media, :content, :recommended)
    end

    def valid_tag(cat, name)
      if cat == "" && name == ""
        return true
      elsif (cat == "" && name != "") || (name == "" && cat != "")
        return false
      else
        return cat.length < 20 && name.length < 30
      end
    end

    def grab_tag(cat, name)
      tag = Tag.find_by(category: cat, name: name)
      if tag.nil?
        tag = Tag.create(category: cat, name: name)
      end
      return tag
    end
end
