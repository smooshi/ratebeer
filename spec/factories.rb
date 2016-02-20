FactoryGirl.define do
  factory :user do
    username "Pekka"
    password "Foobar1"
    password_confirmation "Foobar1"
  end

  factory :rating do
    score 10
  end

  factory :rating2, class: Rating do
    score 20
  end

  factory :rating10, class: Rating do
    score 10
    user
    beer
  end

  factory :rating20, class: Rating do
    score 20
    user
    beer
  end

  factory :brewery do
    name "anonymous"
    year 1900
  end

  factory :brewery2, class: Brewery do
    name "anonymous2"
    year 1901
  end

  factory :beer do
    name "anonymous"
    brewery
    style "Lager"
  end

  factory :beer_ipa do
    name "Punk"
    brewery
    style "IPA"
  end
end