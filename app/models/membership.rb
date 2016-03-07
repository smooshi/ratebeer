class Membership < ActiveRecord::Base
  belongs_to :beer_club
  belongs_to :user

  validates :user_id, presence: true
  validates_uniqueness_of :user_id, :scope => [:user_id, :beer_club_id]

  scope :active, -> { where confirmed:true }
  scope :pending, -> { where confirmed:[nil,false] }
end
