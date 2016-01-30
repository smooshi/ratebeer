class Beer < ActiveRecord::Base
	belongs_to :brewery
	has_many :ratings, dependent: :destroy
	include Average
	
	def monikko(count, singular, plural = nil)
		word = if (count == 1 || count =~ /^1(\.0+)?$/)
			singular
		else
			plural || singular.pluralize
		end
		
		"#{word}"
	end

	def to_s
		return "#{self.name}" + " " + "#{self.brewery.name}"
	end
end