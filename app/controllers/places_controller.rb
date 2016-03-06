class PlacesController < ApplicationController
  def index
  end

  def search
    @places = BeermappingApi.places_in(params[:city])
    session[:last_city] = params[:city] # ÄH.
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      render :index
    end
  end

  def show
    @places = BeermappingApi.places_in(session[:last_city])
    @places.each do |place|
      if place.id == params[:id]
        @place = place
      end
    end
  end

  def set_place

  end
end