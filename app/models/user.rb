class User < ActiveRecord::Base
  has_many :ratings   # käyttäjällä on monta ratingia
  include Average, Monikko


end
