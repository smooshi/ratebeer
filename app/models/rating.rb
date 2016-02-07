class Rating < ActiveRecord::Base
	belongs_to :beer
	belongs_to :user   # rating kuuluu myös käyttäjään
	def to_s
		return "#{self.beer.name}" + " Score: " + "#{self.score}"
	end
end
