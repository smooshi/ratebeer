class Rating < ActiveRecord::Base
	belongs_to :beer, touch: true
	belongs_to :user   # rating kuuluu myös käyttäjään

	validates :score, numericality: { greater_than_or_equal_to: 1,
																		less_than_or_equal_to: 50,
																		only_integer: true }

	#validates :user_id, presence: true
	scope :ordered_by_reverse_order, -> { order('created_at DESC') }

	def to_s
		return "#{self.beer.name}" + " Score: " + "#{self.score}"
	end
end
