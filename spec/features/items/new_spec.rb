require 'rails_helper'

RSpec.describe "Merchant item create" do
  before :each do
    @merch = Merchant.create!(name: "Douglas Olson")
  end

  it "creates a new item" do
    visit merchant_items_path(@merch)
    click_button "Create item"

    expect(current_path).to eq(new_merchant_item_path(@merch))

    fill_in "Name", with: "Rainbow Brite"
    fill_in "Description", with: "Taste the rainbow!"
    fill_in "Price", with: "1468"
    click_button "Submit"

    expect(current_path).to eq(merchant_items_path(@merch))
    expect(page).to have_content("New item created!")

    @item = Item.last

    within "#item-#{@item.id}" do
      expect(page).to have_content("Rainbow Brite")
      expect(@item.status).to eq("disabled")
    end
  end

  it "new item sad path" do
    visit merchant_items_path(@merch)
    click_button "Create item"

    expect(current_path).to eq(new_merchant_item_path(@merch))

    fill_in "Name", with: "Rainbow Brite"
    fill_in "Price", with: "1468"
    click_button "Submit"

    expect(current_path).to eq(new_merchant_item_path(@merch))
    expect(page).to have_content("Item not created. Try again.")
  end
end
