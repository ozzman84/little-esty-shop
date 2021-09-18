require 'rails_helper'

RSpec.describe "Merchant item update" do
  before :each do
    @merch1 = Merchant.create!(name: "Douglas Olson")
    @item1 = @merch1.items.create!(name: "Polly Pocket", description: "So pretty", unit_price: 862, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
  end

  it "has an edit form that updates the item" do
    visit edit_merchant_item_path(@merch1, @item1)

    fill_in "Name", with: "Rainbow Brite"
    fill_in "Description", with: "Taste the rainbow!"
    fill_in "Price", with: "1468"
    click_button "Submit"

    expect(current_path).to eq(merchant_item_path(@merch1, @item1))
    expect(page).to have_content("Item updated!")
    expect(page).to have_content("Rainbow Brite")
    expect(page).to have_content("Taste the rainbow!")
    expect(page).to have_content("$14.68")
  end
end
