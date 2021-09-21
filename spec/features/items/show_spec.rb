require 'rails_helper'

RSpec.describe "Merchant show page" do
  before :each do
    allow_any_instance_of(GithubService).to receive(:get_data).and_return("haha")
    allow_any_instance_of(GithubService).to receive(:pulls).and_return({one: 1, two: 2 })
    allow_any_instance_of(GithubService).to receive(:name).and_return({name: "little-esty-shop"})
    @merch1 = Merchant.create!(name: "Douglas Olson")
    @item1 = @merch1.items.create!(name: "Polly Pocket", description: "So pretty", unit_price: 862, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @item2 = @merch1.items.create!(name: "Cabbage Patch Doll", description: "Cute", unit_price: 1239, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @item3 = @merch1.items.create!(name: "Teddy Ruxpin", description: "Creepy", unit_price: 1543, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @item4 = @merch1.items.create!(name: "Barbie", description: "Gorgeous", unit_price: 2183, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
  end

  it "displays all of an item's attributes" do
    visit merchant_item_path(@merch1, @item1)

    expect(page).to have_content(@item1.name)
    expect(page).to have_content(@item1.description)
    expect(page).to have_content("$8.62")
  end

  it "has a link to update info" do

    visit merchant_item_path(@merch1, @item1)

    click_link 'Update'

    expect(current_path).to eq(edit_merchant_item_path(@merch1, @item1))
  end
end
