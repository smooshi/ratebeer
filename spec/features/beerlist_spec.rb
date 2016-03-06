require 'rails_helper'
include Helpers
describe "beerlist page" do
  let!(:user) { FactoryGirl.create :user }
  before :all do
    self.use_transactional_fixtures = false
    WebMock.disable_net_connect!(allow_localhost:true)
  end

  before :each do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start


    @brewery1 = FactoryGirl.create(:brewery, name: "Koff")
    @brewery2 = FactoryGirl.create(:brewery, name: "Schlenkerla")
    @brewery3 = FactoryGirl.create(:brewery, name: "Ayinger")
    @style1 = Style.create name: "Lager"
    @style2 = Style.create name: "Rauchbier"
    @style3 = Style.create name: "Weizen"
    @beer1 = FactoryGirl.create(:beer, name: "Nikolai", brewery: @brewery1, style: @style1)
    @beer2 = FactoryGirl.create(:beer, name: "Fastenbier", brewery: @brewery2, style: @style2)
    @beer3 = FactoryGirl.create(:beer, name: "Lechte Weisse", brewery: @brewery3, style: @style3)
  end

  after :each do
    DatabaseCleaner.clean
  end

  after :all do
    self.use_transactional_fixtures = true
  end

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "shows a known beer", :js => true do
    visit beerlist_path
    find('table').find('tr:nth-child(2)')
    #save_and_open_page
    expect(page).to have_content "Nikolai"
  end

  it "shows beers in alphabetical order", :js => true do
    visit beerlist_path
    same = false
    beers = Beer.all.sort_by(&:name)
    find('table').find('tr:nth-child(2)')
    (0..beers.count-1).step(1) do |n|
      pagelta = page.all('td')[3*n].text #GHETTORATKAISUT2016, jätän tän nyt tänne muistoksi. :')
      if (pagelta == beers[n].name)
        same = true
      else
        same = false
        break
      end
    end
    expect(same).to eq(true)
  end

  it "shows styles in alphabetical order", :js => true do
    visit beerlist_path
    click_link('style')
    expect(find('table').find('tr:nth-child(2)')).to have_content "Lager"
    expect(find('table').find('tr:nth-child(3)')).to have_content "Rauchbier"
    expect(find('table').find('tr:nth-child(4)')).to have_content "Weizen"

  end

  it "shows breweries in alphabetical order", :js => true do
    visit beerlist_path
    click_link('breweries')
    expect(find('table').find('tr:nth-child(2)')).to have_content "Ayinger"
    expect(find('table').find('tr:nth-child(3)')).to have_content "Koff"
    expect(find('table').find('tr:nth-child(4)')).to have_content "Schlenkerla"

  end


end
