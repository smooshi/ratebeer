class Brewery < ActiveRecord::Base
	has_many :beers, dependent: :destroy
	has_many :ratings, through: :beers
	include Average, Monikko, ApplicationHelper

	#validates :username, presence: true
	validates :year,
						presence: true,
						numericality: { only_integer: true, greater_than_or_equal_to: 1042, less_than_or_equal_to: Date.today.year }

	scope :active, -> { where active:true }
	scope :retired, -> { where active:[nil,false] }

	def print_report
		puts name
		puts "established at year #{year}"
		puts "number of beers #{beers.count}"
	end
	
	def restart
		self.year = 2016
		puts "changed year to #{year}"
	end

	def self.top(n)
		return Brewery.all.sort_by(&:average_rating).reverse.first(n)
	end

end
