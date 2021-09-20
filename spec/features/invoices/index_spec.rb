require 'rails_helper'

RSpec.describe 'the merchant invoices show page' do
  before :each do
    allow_any_instance_of(GithubService).to receive(:get_data).and_return("haha")
    allow_any_instance_of(GithubService).to receive(:pulls).and_return({one: 1, two: 2 })
    allow_any_instance_of(GithubService).to receive(:name).and_return({name: "little-esty-shop"})
    @merch = create(:merchant)
    @item1 = create(:item, merchant_id: @merch.id)
    @item2 = create(:item, merchant_id: @merch.id)
    @item3 = create(:item, merchant_id: @merch.id)
    @invoice1 = create(:invoice)
    @invoice2 = create(:invoice)
    @invoice3 = create(:invoice)
    @inv_item1 = create(:invoice_item, invoice_id: @invoice1.id, item_id: @item1.id)
    @inv_item2 = create(:invoice_item, invoice_id: @invoice2.id, item_id: @item2.id)
  end

  it "shows all invoices that have the merchants items on them as a link" do
    visit "/merchant/#{@merch.id}/invoices"

    within('#invoices')do
      expect(page).to have_content("My Invoices")

      expect(page).to have_link("Invoice ##{@invoice1.id}")
      expect(page).to have_link("Invoice ##{@invoice2.id}")
      expect(page).to_not have_link("Invoice ##{@invoice3.id}")

      click_link "Invoice ##{@invoice1.id}"
      expect(current_path).to eq("/merchant/#{@merch.id}/invoices/#{@invoice1.id}")
    end

    visit "/merchant/#{@merch.id}/invoices"

    within('#invoices')do
      click_link "Invoice ##{@invoice2.id}"
      expect(current_path).to eq("/merchant/#{@merch.id}/invoices/#{@invoice2.id}")
    end
  end
end
