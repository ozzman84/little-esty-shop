require 'rails_helper'

RSpec.describe "Merchant Dashboard" do
  before :each do
    @merch = create(:merchant)
    @merch2 = create(:merchant)
    @item1 = create(:item, merchant_id: @merch.id)
    @item2 = create(:item, merchant_id: @merch.id)
    @item3 = create(:item, merchant_id: @merch2.id)
    @cust = create(:customer)
    @invoice1 = create(:invoice, customer_id: @cust.id)
    @inv_item1 = create(:invoice_item, invoice_id: @invoice1.id, item_id: @item1.id)
    @inv_item2 = create(:invoice_item, invoice_id: @invoice1.id, item_id: @item2.id)
    @inv_item3 = create(:invoice_item, invoice_id: @invoice1.id, item_id: @item3.id)
  end

  it "displays the name of the merchant" do
    visit merchant_dashboard_index_path(@merch.id)

    expect(page).to have_content(@merch.name)
  end

  it "displays links to merchant items and invoices indexes" do
    visit  merchant_dashboard_index_path(@merch.id)

    expect(page).to have_link("My Items")
    click_link "My Items"
    expect(current_path).to eq("/merchant/#{@merch.id}/items")

    visit "/merchant/#{@merch.id}/dashboard"

    expect(page).to have_link("My Invoices")
    click_link "My Invoices"
    expect(current_path).to eq("/merchant/#{@merch.id}/invoices")
  end

  it "displays items ready to ship and their invoice ids" do
    inv_item4 = create(:invoice_item, invoice_id: @invoice1.id, item_id: @item1.id)
    visit merchant_dashboard_index_path(@merch.id)

    within('#ready-to-ship') do
      expect(page).to have_content("Items Ready to Ship")
      expect(page).to have_content(@item1.name, count: 2)
      expect(page).to have_content(@item2.name)
      expect(page).to_not have_content(@item3.name)
    end

    @inv_item1.update(status: 'packaged')
    inv_item4.update(status: 'shipped')
    visit merchant_dashboard_index_path(@merch.id)

    within('#ready-to-ship') do
      expect(page).to have_content("Items Ready to Ship")
      expect(page).to have_content(@item1.name, count: 1)
      expect(page).to have_content(@item2.name)
      expect(page).to_not have_content(@item3.name)
    end
  end

  it "gives invoice ids as links to invoice show pages" do
    @inv_item2.destroy!
    visit merchant_dashboard_index_path(@merch.id)

    within('#ready-to-ship') do
      expect(page).to have_content(@item1.name, count: 1)
      expect(page).to_not have_content(@item2.name)
      expect(page).to have_link("Invoice ##{@invoice1.id}")

      click_link "Invoice ##{@invoice1.id}"
    end

    expect(current_path).to eq(merchant_invoice_path(@merch.id, @invoice1.id))
  end

  it "ready to ship has created at date and order by oldest to newest" do
    @inv_item1.update(created_at: '2012-03-27 14:54:45 UTC')
    @inv_item2.update(created_at: '2012-03-26 14:54:45 UTC')
    visit merchant_dashboard_index_path(@merch.id)

    within('#ready-to-ship') do
      expect(@item2.name).to appear_before(@item1.name)
    end
  end
end
