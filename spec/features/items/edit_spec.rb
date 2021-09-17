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
    expect(page).to have_content("Rainbow Brite")
    expect(page).to have_content("Taste the rainbow!")
    expect(page).to have_content("$14.68")
  end
end

#
# expect(current_path).to eq(edit_merchant_item(@merch1, @item1))
# As a merchant,
# When I visit the merchant show page of an item
# I see a link to update the item information.
# When I click the link
# Then I am taken to a page to edit this item
# And I see a form filled in with the existing item attribute information
# When I update the information in the form and I click ‘submit’
# Then I am redirected back to the item show page where I see the updated information
# And I see a flash message stating that the information has been successfully updated.
