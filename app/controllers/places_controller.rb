class PlacesController < ApplicationController
  def index
  end

  def search
    @places = BeermappingApi.places_in(params[:city])
    @@city = params[:city] # ÄH.
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      render :index
    end
  end

  def show
    @places = BeermappingApi.places_in(@@city)
    @places.each do |place|
      if place.id == params[:id]
        @place = place
      end
    end
  end
end