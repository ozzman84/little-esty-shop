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
    it { should validate_presence_of(:created_at) }
    it { should validate_presence_of(:updated_at) }
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

    describe '.invoice_item_status' do
      it "returns the status of the invoice item associated with item" do
        expect(@item1.invoice_item(@invoice1.id)).to eq(@inv_item1)
        expect(@item2.invoice_item(@invoice1.id)).to eq(@inv_item2)
      end
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
end
