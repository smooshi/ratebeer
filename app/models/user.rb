class User < ActiveRecord::Base
  has_many :ratings   # käyttäjällä on monta ratingia
  has_many :beers, through: :ratings

  has_many :memberships
  has_many :beer_clubs, through: :memberships

  include Average, Monikko

  validates :username, uniqueness: true, length: { minimum: 3, maximum: 15 }

end
