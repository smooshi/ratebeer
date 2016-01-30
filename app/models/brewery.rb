class Brewery < ActiveRecord::Base
	has_many :beers, dependent: :destroy
	has_many :ratings, through: :beers
	include Average

	def print_report
		puts name
		puts "established at year #{year}"
		puts "number of beers #{beers.count}"
	end
	
	  def restart
		self.year = 2016
		puts "changed year to #{year}"
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
