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

  def favorite_beer
    return nil if ratings.empty?
    ratings.sort_by(&:score).last.beer
  end

  def favorite_brewery
    return nil if ratings.empty?
    breweries = Hash.new(0)
    ratings.group_by{|rating| rating.beer.brewery.name}.each do |name, group|
        breweries[name] = group.map { |h| h[:score] }.sum/group.count
    end
    return breweries.sort_by{|k,v| v}.last[0]
  end

  def favorite_style
    return nil if ratings.empty?
    styles = Hash.new(0)
    ratings.group_by{|rating| rating.beer.style}.each do |name, group|
      styles[name] = group.map { |h| h[:score] }.sum/group.count
    end
    return styles.sort_by{|k,v| v}.last[0]
  end
end
