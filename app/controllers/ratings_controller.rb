class RatingsController < ApplicationController

  def index
  #@users = User.all.sort_by(&:num_of_ratings).reverse
  @users = User.active(3)
  @beers = Beer.top(3)
  @breweries = Brewery.top(3)
	@ratings = Rating.all
  @styles = Style.top(3)
  @newest_rating = Rating.ordered_by_reverse_order

  end
  
  def new
    @rating = Rating.new
    @beers = Beer.all
  end
  
  def create
    #require 'byebug'
      #byebug
    @rating = Rating.create params.require(:rating).permit(:score, :beer_id)

    # talletetaan tehdyn reittauksen sessioon
    #session[:last_rating] = "#{rating.beer.name} #{rating.score} points"

    if @rating.save
      current_user.ratings << @rating
      redirect_to user_path current_user
    else
      @beers = Beer.all
      render :new
    end
  end

  def destroy
    rating = Rating.find(params[:id])
    rating.delete if current_user == rating.user
    redirect_to :back
  end
end