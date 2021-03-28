class HomeController < ApplicationController
  before_action :set_user, only: %i[show]

  #load data from the database for the different classes (just for Hello World version, 
  #and we are still figuring this out ;) )
  def index
    @users = User.all
    @reviews = Review.all
  end
end
