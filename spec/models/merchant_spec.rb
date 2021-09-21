require 'rails_helper'

RSpec.describe Merchant do
  describe 'relationships' do
    it { should have_many(:items) }
    it { should have_many(:invoices).through :items }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'instance methods' do
    before :each do
      @merch = create_list(:merchant, 7)
      @item1 = create(:item, merchant: @merch[0], status: 'enabled')
      @item2 = create(:item, merchant: @merch[0], status: 'enabled')
      @item3 = create(:item, merchant: @merch[0], status: 'disabled')
      @item4 = create(:item, merchant: @merch[1])
      @item5 = create(:item, merchant: @merch[2])
      @item6 = create(:item, merchant: @merch[3])
      @item7 = create(:item, merchant: @merch[4])
      @item8 = create(:item, merchant: @merch[5])
      @item9 = create(:item, merchant: @merch[6])
      @invoice = create(:invoice, updated_at: "2012-03-26 09:54:09")
      @invoice1 = create(:invoice, updated_at: "2012-03-25 09:54:09")
      @invoice2 = create(:invoice, updated_at: "2012-03-25 09:54:09")
      @invoice3 = create(:invoice, updated_at: "2012-03-25 09:54:09")
      @invoice4 = create(:invoice, updated_at: "2012-03-25 09:54:09")
      @invoice5 = create(:invoice, updated_at: "2012-03-25 09:54:09")
      @invoice6 = create(:invoice, updated_at: "2012-03-25 09:54:09")
      @invoice7 = create(:invoice, updated_at: "2012-03-25 09:54:09")
      @invoice8 = create(:invoice, updated_at: "2012-03-25 09:54:09")
      @inv_item1 = create(:invoice_item, invoice: @invoice, item: @item1, unit_price: 2000, quantity: 1)
      @inv_item2 = create(:packaged_invoice_item, invoice: @invoice, item: @item1, unit_price: 1000, quantity: 1)
      @inv_item3 = create(:invoice_item, invoice: @invoice1, item: @item2, unit_price: 1000, quantity: 1)
      @inv_item4 = create(:shipped_invoice_item, invoice: @invoice1, item: @item2, unit_price: 1000, quantity: 1)
      @inv_item5 = create(:invoice_item, invoice: @invoice2, item: @item4, unit_price: 1000, quantity: 1)
      @inv_item6 = create(:invoice_item, invoice: @invoice3, item: @item5, unit_price: 2000, quantity: 2)
      @inv_item7 = create(:invoice_item, invoice: @invoice4, item: @item6, unit_price: 3000, quantity: 1)
      @inv_item8 = create(:invoice_item, invoice: @invoice5, item: @item6, unit_price: 2500, quantity: 2)
      @inv_item9 = create(:invoice_item, invoice: @invoice5, item: @item7, unit_price: 1500, quantity: 2)
      @inv_item10 = create(:invoice_item, invoice: @invoice5, item: @item8, unit_price: 3500, quantity: 2)
      @inv_item11 = create(:invoice_item, invoice: @invoice6, item: @item9, unit_price: 3000, quantity: 3)
      @inv_item13 = create(:invoice_item, invoice: @invoice8, item: @item3, unit_price: 3000, quantity: 3)
      @transaction = create(:transaction, invoice: @invoice)
      @transaction2 = create(:transaction, invoice: @invoice1)
      @transaction3 = create(:transaction, invoice: @invoice2)
      @transaction4 = create(:transaction, invoice: @invoice3)
      @transaction5 = create(:transaction, invoice: @invoice4)
      @transaction6 = create(:transaction, invoice: @invoice5)
      @transaction7 = create(:failed_transaction, invoice: @invoice6)
      @transaction8 = create(:failed_transaction, invoice: @invoice4)
    end

    describe '.all_invoices' do
      it "returns all invoices for a merchant" do
        expect(@merch[0].all_invoices).to eq([@invoice, @invoice1, @invoice8])
      end
    end

    describe '.ready_to_ship' do
      it "returns all items for a merchant that are not shipped" do
        expect(@merch[0].ready_to_ship.size).to eq(4)
        expect(@merch[0].ready_to_ship.first.name).to eq(@item1.name)
        expect(@merch[0].ready_to_ship.second.name).to eq(@item1.name)
        expect(@merch[0].ready_to_ship.third.name).to eq(@item2.name)
      end
    end

    describe 'Top Merchants' do
      it 'returns top 5 merchants by revenue' do
        expect(Merchant.top_5_by_rev).to eq([@merch[3], @merch[5], @merch[0], @merch[2], @merch[4]])
      end

      it 'returns Merchant\'s best day' do
        expect(@merch[0].best_day).to eq("2012-03-26 09:54:09")
      end
    end
  end
end
