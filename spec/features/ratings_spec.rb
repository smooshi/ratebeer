require 'rails_helper'

include Helpers

describe "Rating" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:style1) { FactoryGirl.create :style, name:"Lager" }
  let!(:style2) { FactoryGirl.create :style, name:"IPA" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery, style:style1 }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery, style:style2 }
  let!(:user) { FactoryGirl.create :user }
  let!(:rating10) { FactoryGirl.create :rating10, beer:beer1, user:user }
  let!(:rating20) { FactoryGirl.create :rating20, beer:beer2, user:user }

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(2).to(3)

    expect(user.ratings.count).to eq(3)
    expect(beer1.ratings.count).to eq(2)
    expect(beer1.average_rating).to eq(12.0)
  end

  it "all ratings and count is displayed in ratings page" do
    visit ratings_path
    expect(page).to have_content 'Number of ratings: 2'
  end


end