require 'rails_helper'

RSpec.describe InvoiceItem do
  describe 'relationships' do
    it { should belong_to(:item) }
    it { should belong_to(:invoice) }
  end

  describe 'validations' do
    it { should validate_presence_of(:quantity) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:created_at) }
    it { should validate_presence_of(:updated_at) }
  end

  before :each do
    @merch = create(:merchant)
    @merch2 = create(:merchant)
    @item1 = create(:item, merchant_id: @merch.id)
    @item2 = create(:item, merchant_id: @merch.id)
    @item3 = create(:item, merchant_id: @merch2.id)
    @cust = create(:customer)
    @invoice1 = create(:invoice, customer_id: @cust.id)
    @inv_item1 = create(:invoice_item, unit_price: @item1.unit_price, invoice_id: @invoice1.id, item_id: @item1.id)
    @inv_item2 = create(:invoice_item, unit_price: @item2.unit_price, invoice_id: @invoice1.id, item_id: @item2.id)
    @inv_item3 = create(:invoice_item, unit_price: @item2.unit_price, invoice_id: @invoice1.id, item_id: @item3.id)
  end

  describe 'class methods' do
    describe '#on_merchant_invoice' do
      it 'returns all invoice items with given invoice and merchant id' do
        expect(InvoiceItem.on_merchant_invoice(@invoice1.id, @merch.id)).to eq([@inv_item1, @inv_item2])
        expect(InvoiceItem.on_merchant_invoice(@invoice1.id, @merch2.id)).to eq([@inv_item3])
      end
    end

    describe '#total_rev' do
      it 'returns the total revenue' do
        @inv_item1.update(quantity: 2)
        @inv_item2.update(quantity: 2)
        @inv_item3.update(quantity: 2)
        @inv_item1.update(unit_price:  50)
        @inv_item2.update(unit_price:  25)
        @inv_item3.update(unit_price:  75)

        expect(InvoiceItem.total_rev).to eq('3.00')
      end
    end
  end

  describe 'instance methods' do
    describe '.get_item' do
      it 'returns the item on the invoice' do
        expect(@inv_item1.get_item).to eq(@item1)
        expect(@inv_item2.get_item).to eq(@item2)
        expect(@inv_item3.get_item).to eq(@item3)
      end
    end

    describe '.price_dollars' do
      it "return the unit price * quantity formatted in dollars" do
        @inv_item1.unit_price = 3330
        expect(@inv_item1.price_dollars).to eq('33.30')
        expect(@inv_item1.price_dollars(2)).to eq('66.60')
      end
    end
  end
end
