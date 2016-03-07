class RatingsController < ApplicationController
  before_action :expire_cached_toplist, only:[:create]

  def index
  @ratings = Rating.includes(:beer, :style, :breweries, :user).all
  @beers = Rails.cache.read "beer top 3"
  @users = Rails.cache.read "user top 3"
  @breweries = Rails.cache.read "brewery top 3"
  @styles = Rails.cache.read "style top 3"
  @newest_rating = @ratings.reverse_order

    #Heroku ajaa "rake update_rating_cache" 10min välein, mutta cache clearaa myös kun tehdään uusi rating koska olisi kurjaa tehdä uusi ja ei nähdä sitä?
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

  private
  def expire_cached_toplist
    ["beer top 3", "style top 3", "brewery top 3", "user top 3"].each{ |f| expire_fragment(f) }
  end
end