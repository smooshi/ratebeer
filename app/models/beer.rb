class Beer < ActiveRecord::Base
	belongs_to :brewery
	has_many :ratings, dependent: :destroy
	include Average, Monikko

	def to_s
		return "#{self.name}" + " " + "#{self.brewery.name}"
	end
end