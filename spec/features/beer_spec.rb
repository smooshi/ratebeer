require 'rails_helper'

include Helpers

describe "Beer" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:style) { FactoryGirl.create :style, name:"Lager" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery, style:style }
  let!(:user) { FactoryGirl.create :user }

  it "create beer with valid name" do
    sign_in(username:"Pekka", password:"Foobar1")
    visit new_beer_path
    #save_and_open_page
    fill_in('beer_name', with:"HienoOlut")
    click_button('Create Beer')
    expect(page).to have_content 'HienoOlut'
    #save_and_open_page
  end

end