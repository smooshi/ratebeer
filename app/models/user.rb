class User < ActiveRecord::Base
  has_many :ratings   # käyttäjällä on monta ratingia
  has_many :beers, through: :ratings

  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships

  include Average, Monikko

  PASSWORD_FORMAT = /\A
    (?=.*\d)           # Must contain a digit
    (?=.*[A-Z])        # Must contain an upper case character
  /x

  validates :username, uniqueness: true, length: { minimum: 3, maximum: 15 }

  validates  :password, length: { minimum: 4 }, format: {with: PASSWORD_FORMAT}

  has_secure_password

end
