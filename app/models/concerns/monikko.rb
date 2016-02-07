module Monikko
  extend ActiveSupport::Concern
  def monikko(count, singular, plural = nil)
    word = if (count == 1 || count =~ /^1(\.0+)?$/)
             singular
           else
             plural || singular.pluralize
           end

    "#{word}"
  end
end