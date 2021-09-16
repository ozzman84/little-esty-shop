require 'rails_helper'

RSpec.describe 'the merchant invoices show page' do
  before :each do
    @merch = create(:merchant)
    @item1 = create(:item, merchant_id: @merch.id)
    @item2 = create(:item, merchant_id: @merch.id)
    @item3 = create(:item, merchant_id: @merch.id)
    @cust = create(:customer)
    @invoice1 = create(:invoice, customer_id: @cust.id)
    @inv_item1 = create(:invoice_item, invoice_id: @invoice1.id, item_id: @item1.id)
    @inv_item2 = create(:invoice_item, invoice_id: @invoice1.id, item_id: @item2.id)
  end

  it "shows invoice attribues" do
    visit "/merchant/#{@merch.id}/invoices/#{@invoice1.id}"

    within('#attributes') do
      expect(page).to have_content("Invoice ##{@invoice1.id}")
      expect(page).to have_content("Status: #{@invoice1.status}")
      expect(page).to have_content("Created on: Tuesday, March 27, 2012")
      expect(page).to have_content("Customer: #{@cust.first_name} #{@cust.last_name}")
    end
  end
end
