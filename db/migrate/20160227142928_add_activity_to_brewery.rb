class AddActivityToBrewery < ActiveRecord::Migration
  def change
    add_column :breweries, :active, :boolean, default: true
  end
end
