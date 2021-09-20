require 'rails_helper'

RSpec.describe Merchant do
  describe 'relationships' do
    it { should have_many(:items) }
    it { should have_many(:invoices).through :items }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    # it { should validate_presence_of(:created_at) }
    # it { should validate_presence_of(:updated_at) }
  end

  describe 'instance methods' do
    before :each do
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

    describe 'all_invoices' do
      it 'returns all invoices for a merchant' do
        expect(@merch.all_invoices).to eq([@invoice1, @invoice2])
      end
    end

    describe 'Top Merchants' do
      it 'returns top 5 merchants by revenue' do
        expect(@merch.top_5_by_rev).to eq([])
      end
    end
  end
end
