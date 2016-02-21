require 'rails_helper'

include Helpers

describe "User" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:brewery2) { FactoryGirl.create :brewery, name:"BrewDog" }
  let!(:style1) { FactoryGirl.create :style, name:"Lager" }
  let!(:style2) { FactoryGirl.create :style, name:"IPA" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery, style:style1 }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery2, style:style2 }
  let!(:user) { FactoryGirl.create :user }
  let!(:rating10) { FactoryGirl.create :rating10, beer:beer1, user:user }
  let!(:rating20) { FactoryGirl.create :rating20, beer:beer2, user:user }

  describe "who has signed up" do
    it "can signin with right credentials" do
      sign_in(username:"Pekka", password:"Foobar1")

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end

    it "is redirected back to signin form if wrong credentials given" do
      sign_in(username:"Pekka", password:"wrong")

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Username and/or password mismatch'
    end
  end

  it "when signed up with good credentials, is added to the system" do
    visit signup_path
    fill_in('user_username', with:'Brian')
    fill_in('user_password', with:'Secret55')
    fill_in('user_password_confirmation', with:'Secret55')

    expect{
      click_button('Create User')
    }.to change{User.count}.by(1)
  end

  it "ratings are show on user page" do
    sign_in(username:"Pekka", password:"Foobar1")
    click_link 'Pekka'
    expect(page).to have_content 'iso 3'
    expect(page).to have_content 'Karhu'
    expect(page).to have_content 'User has 2 ratings'
  end

  it "rating is removed successfully" do
    sign_in(username:"Pekka", password:"Foobar1")
    click_link 'Pekka'
    first('.rating').click_link('delete')
    expect(page).to have_content 'Karhu'
    expect(page).to have_content 'User has 1 rating'
  end

  it "user has correct favorite style" do
    sign_in(username:"Pekka", password:"Foobar1")
    click_link 'Pekka'
    expect(page).to have_content 'IPA'
  end

  it "user has correct favorite brewery" do
    sign_in(username:"Pekka", password:"Foobar1")
    click_link 'Pekka'
    expect(page).to have_content 'BrewDog'
  end
end