class User < ActiveRecord::Base
  has_many :ratings   # käyttäjällä on monta ratingia
  has_many :beers, through: :ratings

  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships

  include Average, Monikko, ApplicationHelper

  PASSWORD_FORMAT = /\A
    (?=.*\d)           # Must contain a digit
    (?=.*[A-Z])        # Must contain an upper case character
  /x

  validates :username, uniqueness: true, length: { minimum: 3, maximum: 15 }

  validates  :password, length: { minimum: 4 }, format: {with: PASSWORD_FORMAT}

  has_secure_password

  def favorite_beer
    return nil if ratings.empty?
    ratings.sort_by{ |r| r.score }.last.beer
  end

  def favorite_style
    favorite :style
  end

  def favorite_brewery
    favorite :brewery
  end

  def favorite(category)
    return nil if ratings.empty?

    rated = ratings.map{ |r| r.beer.send(category) }.uniq
    rated.sort_by { |item| -rating_of(category, item) }.first
  end

  def rating_of(category, item)
    ratings_of = ratings.select{ |r| r.beer.send(category)==item }
    ratings_of.map(&:score).inject(&:+) / ratings_of.count.to_f
  end

  def num_of_ratings
    return 0 if ratings.empty?
    return ratings.count
  end

  def self.mostActive(n)
    return User.all.sort_by(&:num_of_ratings).reverse.first(n)
  end
end
