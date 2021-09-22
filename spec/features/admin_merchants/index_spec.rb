require 'rails_helper'

describe 'Admin Merchants Index' do
  before :each do
    allow_any_instance_of(GithubService).to receive(:get_data).and_return('haha')
    allow_any_instance_of(GithubService).to receive(:pulls).and_return({ one: 1, two: 2 })
    allow_any_instance_of(GithubService).to receive(:name).and_return({ name: 'little-esty-shop' })
    @merch = create_list(:merchant, 7, status: 'enabled')
    @merch_dis = create_list(:merchant, 7, status: 'disabled')
    @item1 = create(:item, merchant: @merch[0], status: 'enabled')
    @item2 = create(:item, merchant: @merch[0], status: 'enabled')
    @item3 = create(:item, merchant: @merch[0], status: 'disabled')
    @item4 = create(:item, merchant: @merch[1])
    @item5 = create(:item, merchant: @merch[2])
    @item6 = create(:item, merchant: @merch[3])
    @item7 = create(:item, merchant: @merch[4])
    @item8 = create(:item, merchant: @merch[5])
    @item9 = create(:item, merchant: @merch[6])
    @invoice = create_list(:invoice, 7)
    @inv_item1 = create(:invoice_item, invoice: @invoice[0], item: @item1, unit_price: 2000, quantity: 1)
    @inv_item2 = create(:packaged_invoice_item, invoice: @invoice[0], item: @item1, unit_price: 1000, quantity: 1)
    @inv_item3 = create(:invoice_item, invoice: @invoice[1], item: @item2, unit_price: 1000, quantity: 1)
    @inv_item4 = create(:shipped_invoice_item, invoice: @invoice[1], item: @item2, unit_price: 1000, quantity: 1)
    @inv_item5 = create(:invoice_item, invoice: @invoice[2], item: @item4, unit_price: 1000, quantity: 1)
    @inv_item6 = create(:invoice_item, invoice: @invoice[3], item: @item5, unit_price: 2000, quantity: 2)
    @inv_item7 = create(:invoice_item, invoice: @invoice[4], item: @item6, unit_price: 3000, quantity: 1)
    @inv_item8 = create(:invoice_item, invoice: @invoice[5], item: @item6, unit_price: 2500, quantity: 2)
    @inv_item9 = create(:invoice_item, invoice: @invoice[5], item: @item7, unit_price: 1500, quantity: 2)
    @inv_item10 = create(:invoice_item, invoice: @invoice[5], item: @item8, unit_price: 3500, quantity: 2)
    @inv_item11 = create(:invoice_item, invoice: @invoice[6], item: @item9, unit_price: 3000, quantity: 3)
    @transaction = create(:transaction, invoice: @invoice[0])
    @transaction2 = create(:transaction, invoice: @invoice[1])
    @transaction3 = create(:transaction, invoice: @invoice[2])
    @transaction4 = create(:transaction, invoice: @invoice[3])
    @transaction5 = create(:transaction, invoice: @invoice[4])
    @transaction6 = create(:transaction, invoice: @invoice[5])
    @transaction7 = create(:failed_transaction, invoice: @invoice[6])
    @transaction8 = create(:failed_transaction, invoice: @invoice[4])
    @merchants = Merchant.all
  end

  describe 'show all merchants' do
    it 'lists names of all Merchants' do
      visit admin_merchants_path

      @merch.each do |m|
        expect(page).to have_content(m.name)
      end
    end
  end

  describe 'Admin Enable/Disable Merchants' do
    it 'can enable or disable with botton click' do
      visit admin_merchants_path

      @merch.each do |m|
        within("##{m.id}") do
          expect(page).to have_button('Disable')
        end
      end

      @merch_dis.each do |d|
        within("##{d.id}") do
          expect(page).to have_button('Enable')
        end
      end
    end

    it 'can click enable to disable' do
      visit admin_merchants_path

      within("##{@merch[0].id}") do
        click_button 'Disable'
      end
      @merch[0].reload

      expect(@merch[0].status).to eq('disabled')

      within("##{@merch[0].id}") do
        expect(page).to have_button('Enable')
      end
    end
  end

  describe 'groups by status' do
    it 'groups by Enabled' do
      visit admin_merchants_path

      within('#Enabled-table') do
        @merch.each do |m|
          expect(page).to have_content(m.name)
        end
      end

      within('#Disabled-table') do
        @merch_dis.each do |d|
          expect(page).to have_content(d.name)
        end
      end
    end
  end

  describe 'Top 5 Merchants' do
    it 'ordered merchants name by revenue' do
      visit admin_merchants_path

      @merchants.top_5_by_rev.each do |m|
        within("#Top-#{m.id}") do
          expect(page).to have_content(m.name)
          expect(page).to have_link(m.name)
          expect(page).to have_content("$#{m.total_rev / 100.0}")
          expect(page).to have_content(m.best_day.last.top_date)
        end
      end
    end
  end
end
