
module Average
  extend ActiveSupport::Concern
  def average_rating
    if ratings.count > 0
      return ratings.map { |h| h[:score] }.sum/ratings.count
    end
  end
end