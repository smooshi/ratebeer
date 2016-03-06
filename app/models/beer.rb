class Beer < ActiveRecord::Base
	belongs_to :brewery, touch: true
	belongs_to :style
	has_many :ratings, dependent: :destroy
	has_many :users, through: :ratings

	include Average, Monikko, ApplicationHelper

	validates :name,  { presence: true}

  validates :style, {presence: true}

	def to_s
		return "#{self.name}" + " " + "#{self.brewery.name}"
	end

  def self.top(n)
		return Beer.all.sort_by(&:average_rating).reverse.first(n)
	end
end