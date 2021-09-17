require 'rails_helper'

RSpec.describe "Merchant item index" do
  before :each do
    @merch1 = Merchant.create!(name: "Douglas Olson")
    @item1 = @merch1.items.create!(name: "Polly Pocket", description: "So pretty", unit_price: 862, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @item2 = @merch1.items.create!(name: "Cabbage Patch Doll", description: "Cute", unit_price: 1239, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @item3 = @merch1.items.create!(name: "Teddy Ruxpin", description: "Creepy", unit_price: 1543, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @item4 = @merch1.items.create!(name: "Barbie", description: "Gorgeous", unit_price: 2183, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @item5 = @merch2.items.create!(name: "GI Joe", description: "Imperialism", unit_price: 743, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
  end

  it "displays all of an item's attributes" do
    visit merchant_item_path(@item1.id)

    expect(page).to have_content(@item1.name)
    expect(page).to have_content(@item1.description)
    expect(page).to have_content(@item1.unit_price)
  end
end



#
# As a merchant,
# When I click on the name of an item from the merchant items index page,
# Then I am taken to that merchant's item's show page (/merchant/merchant_id/items/item_id)
# And I see all of the item's attributes including:
#
# Name
# Description
# Current Selling Price
