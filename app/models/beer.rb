class Beer < ActiveRecord::Base
	belongs_to :brewery
	has_many :ratings
	
	def average_rating
		if ratings.count > 0
			return ratings.map { |h| h[:score] }.sum/ratings.count
		end
	end
	
	def monikko(count, singular, plural = nil)
		word = if (count == 1 || count =~ /^1(\.0+)?$/)
			singular
		else
			plural || singular.pluralize
		end
		
		"#{word}"
	end
end