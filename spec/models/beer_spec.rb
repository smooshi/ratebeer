require 'rails_helper'

RSpec.describe Beer, type: :model do
  it "is saved with name and style" do
    beer = Beer.create name:"Olut", style:"IPA"

    expect(beer.valid?).to eq(true)
    expect(Beer.count).to eq(1)
  end

  it "is not saved without a name" do
    beer = Beer.create style:"IPA"

    expect(beer.valid?).to eq(false)
    expect(Beer.count).to eq(0)
  end

  it "is not saved without a style" do
    beer = Beer.create name:"Olut"

    expect(beer.valid?).to eq(false)
    expect(Beer.count).to eq(0)
  end

  describe "when one beer exists" do
    let(:beer){FactoryGirl.create(:beer)}

    it "is valid" do
      expect(beer).to be_valid
    end

    it "has the default style" do
      expect(beer.style).to eq("Lager")
    end
  end

end