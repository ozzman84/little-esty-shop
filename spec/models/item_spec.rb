require 'rails_helper'

RSpec.describe Item do
  describe 'relationships' do
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items) }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:unit_price) }
  end

  describe 'instance methods' do

    before :each do
      @merch = create(:merchant)
      @merch2 = create(:merchant)
      @item1 = create(:item, merchant_id: @merch.id)
      @item2 = create(:item, merchant_id: @merch.id)
      @item3 = create(:item, merchant_id: @merch2.id)
      @cust = create(:customer)
      @invoice1 = create(:invoice, customer_id: @cust.id)
      @inv_item1 = create(:invoice_item, invoice_id: @invoice1.id, item_id: @item1.id)
      @inv_item2 = create(:packaged_invoice_item, invoice_id: @invoice1.id, item_id: @item2.id)
      @inv_item3 = create(:invoice_item, invoice_id: @invoice1.id, item_id: @item3.id)
    end

    it "has a default status of disabled" do
      expect(@item1.status).to eq('disabled')
      @item1.enabled!
      expect(@item1.status).to eq('enabled')
    end

    describe '.price_dollars' do
      it "return the unit price * quantity formatted in dollars" do
        @item1.unit_price = 3330
        expect(@item1.price_dollars).to eq('33.30')
        expect(@item1.price_dollars(2)).to eq('66.60')
      end
    end

    describe '.unit_price_dollars' do
      it "return the unit price per item formatted in dollars" do
        @item1.unit_price = 3330
        expect(@item1.unit_price_dollars).to eq('33.30')
      end
    end
  end

  describe "best day" do
    before :each do
      @merch = create(:merchant)
      @items = create_list(:item, 7, merchant: @merch)
      @customer = create(:customer)
      @inv0 = create(:invoice, customer: @customer, created_at: "2014-05-10 14:53:59 UTC")
      @inv1 = create(:invoice, customer: @customer, created_at: "2016-03-27 14:53:59 UTC")
      @inv2 = create(:invoice, customer: @customer, created_at: "2012-01-06 14:53:59 UTC")
      @inv3 = create(:invoice, customer: @customer, created_at: "2012-03-27 14:53:59 UTC")
      @inv4 = create(:invoice, customer: @customer, created_at: "2010-08-03 14:53:59 UTC")
      @ii_1 = create(:invoice_item, invoice: @inv0, item: @items[1], quantity: 2, unit_price: 100)
      @ii_2 = create(:invoice_item, invoice: @inv0, item: @items[2], quantity: 10, unit_price: 200)
      @ii_3 = create(:invoice_item, invoice: @inv1, item: @items[3], quantity: 4, unit_price: 40)
      @ii_4 = create(:invoice_item, invoice: @inv1, item: @items[4], quantity: 12, unit_price: 30)
      @ii_5 = create(:invoice_item, invoice: @inv1, item: @items[5], quantity: 20, unit_price: 90)
      @ii_6 = create(:invoice_item, invoice: @inv2, item: @items[6], quantity: 3, unit_price: 50)
      @ii_7 = create(:invoice_item, invoice: @inv2, item: @items[1], quantity: 6, unit_price: 80)
      @ii_8 = create(:invoice_item, invoice: @inv3, item: @items[2], quantity: 10, unit_price: 75)
      @ii_9 = create(:invoice_item, invoice: @inv3, item: @items[2], quantity: 7, unit_price: 60)
      @ii_10 = create(:invoice_item, invoice: @inv4, item: @items[0], quantity: 1000, unit_price: 800)
      @trans1 = create(:transaction, invoice: @inv0)
      @trans2 = create(:transaction, invoice: @inv1)
      @trans3 = create(:transaction, invoice: @inv2)
      @trans4 = create(:transaction, invoice: @inv3)
      @trans5 = create(:failed_transaction, invoice: @inv3)
      @trans6 = create(:failed_transaction, invoice: @inv4)
    end

    it "returns an item's best day" do
      expect(@items[1].best_day).to eq(@inv2.created_at)
      expect(@items[2].best_day).to eq(@inv0.created_at)
      expect(@items[3].best_day).to eq(@inv1.created_at)
      expect(@items[4].best_day).to eq(@inv1.created_at)
      expect(@items[5].best_day).to eq(@inv1.created_at)
      expect(@items[6].best_day).to eq(@inv2.created_at)
    end
  end
end
