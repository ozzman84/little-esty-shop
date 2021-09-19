require 'rails_helper'

RSpec.describe Merchant do
  describe 'relationships' do
    it { should have_many(:items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    # it { should validate_presence_of(:created_at) }
    # it { should validate_presence_of(:updated_at) }
  end

  describe 'instance methods' do
    before :each do
      @merch = create(:merchant)
      @merch2 = create(:merchant)
      @item1 = create(:item, merchant_id: @merch.id, status: 'enabled')
      @item2 = create(:item, merchant_id: @merch.id, status: 'enabled')
      @item3 = create(:item, merchant_id: @merch.id, status: 'disabled')
      @item4 = create(:item, merchant_id: @merch2.id)
      @invoice1 = create(:invoice)
      @invoice2 = create(:invoice)
      @invoice3 = create(:invoice)
      @inv_item1 = create(:invoice_item, invoice_id: @invoice1.id, item_id: @item1.id)
      @inv_item2 = create(:packaged_invoice_item, invoice_id: @invoice1.id, item_id: @item1.id)
      @inv_item3 = create(:invoice_item, invoice_id: @invoice2.id, item_id: @item2.id)
      @inv_item4 = create(:shipped_invoice_item, invoice_id: @invoice2.id, item_id: @item2.id)
      @inv_item5 = create(:invoice_item, invoice_id: @invoice3.id, item_id: @item4.id)
    end

    describe '.all_invoices' do
      it "returns all invoices for a merchant" do
        expect(@merch.all_invoices).to eq([@invoice1, @invoice2])
      end
    end

    describe '.ready_to_ship' do
      it "returns all items for a merchant that are not shipped" do
        expect(@merch.ready_to_ship.size).to eq(3)
        expect(@merch.ready_to_ship.first.name).to eq(@item1.name)
        expect(@merch.ready_to_ship.second.name).to eq(@item1.name)
        expect(@merch.ready_to_ship.third.name).to eq(@item2.name)
      end
    end

    describe '.items_status' do
      it "returns all items with a specific status for a merchant" do
        expect(@merch.items_status('enabled')).to eq([@item1, @item2])
        expect(@merch.items_status('disabled')).to eq([@item3])
      end
    end

  end
end
