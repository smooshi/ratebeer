

class RatingsController < ApplicationController

  def index
	@ratings = Rating.all
  end
  
  def new
    @rating = Rating.new
  end
  
  def create
	#require 'byebug'
    #byebug
	Rating.create params.require(:rating).permit(:score, :beer_id)
	redirect_to ratings_path
  end
  
end