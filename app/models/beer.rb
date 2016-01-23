class Beer < ActiveRecord::Base
	belongs_to :brewery
	has_many :ratings
	
	def average_rating
		if ratings.count > 0
			ka = 0
			count = 0
			ratings.each do |r|
				ka = ka + r.score
				count = count + 1
			end
			return ka/count
		end
	end
	
end