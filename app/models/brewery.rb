class Brewery < ActiveRecord::Base
	has_many :beers, dependent: :destroy
	has_many :ratings, through: :beers
	include Average, Monikko

	#validates :username, presence: true
	validates :year,
						presence: true,
						numericality: { only_integer: true, greater_than_or_equal_to: 1042, less_than_or_equal_to: Date.today.year }

	def print_report
		puts name
		puts "established at year #{year}"
		puts "number of beers #{beers.count}"
	end
	
	  def restart
		self.year = 2016
		puts "changed year to #{year}"
    end

end
