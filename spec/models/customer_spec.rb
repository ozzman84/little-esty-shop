require 'rails_helper'

RSpec.describe Customer, type: :model do
  before :each do
    @merchant = create(:merchant)
    @merchant2 = create(:merchant)

    @customers = create_list(:customer, 7)
    @customer2 = create(:customer)

    @items = create_list(:item, 7, merchant: @merchant)
    @item2 = create(:item, merchant: @merchant2)

    @invoice_0 = create(:invoice, customer: @customers[0])
    @invoice_1 = create(:invoice, customer: @customers[1])
    @invoice_2 = create(:invoice, customer: @customers[2])
    @invoice_3 = create(:invoice, customer: @customers[3])
    @invoice_4 = create(:invoice, customer: @customers[4])
    @invoice_5 = create(:invoice, customer: @customers[5])
    @invoice_6 = create(:invoice, customer: @customers[6])
    @invoice_7 = create(:invoice, customer: @customer2)

    @ii_1 = create(:invoice_item, item: @items[0], invoice: @invoice_0)
    @ii_2 = create(:invoice_item, item: @items[0], invoice: @invoice_1)
    @ii_3 = create(:invoice_item, item: @items[1] , invoice: @invoice_2)
    @ii_4 = create(:invoice_item, item: @items[1], invoice: @invoice_3)
    @ii_5 = create(:invoice_item, item: @items[2], invoice: @invoice_3)
    @ii_6 = create(:invoice_item, item: @items[3], invoice: @invoice_3)
    @ii_7 = create(:invoice_item, item: @items[4] , invoice: @invoice_4)
    @ii_8 = create(:invoice_item, item: @items[5], invoice: @invoice_5)
    @ii_9 = create(:invoice_item, item: @items[6], invoice: @invoice_6)
    @ii_10 = create(:invoice_item, item: @item2, invoice: @invoice_7)

    @trans_success_1 = create_list(:transaction, 4, invoice: @invoice_1)
    @trans_success_2 = create(:transaction, invoice: @invoice_2)
    @trans_success_3 = create_list(:transaction, 2, invoice: @invoice_3)
    @trans_success_4 = create_list(:transaction, 3, invoice: @invoice_4)
    @trans_success_5 = create_list(:transaction, 5, invoice: @invoice_5)
    @trans_success_7 = create_list(:transaction, 7, invoice: @invoice_7)

    @trans_failed_1 = create(:failed_transaction, invoice: @invoice_1)
    @trans_failed_2 = create(:failed_transaction, invoice: @invoice_2)
    @trans_failed_6 = create(:failed_transaction, invoice: @invoice_6)
    @trans_failed_7 = create(:failed_transaction, invoice: @invoice_7)
  end

  describe 'relationships' do
    it { should have_many(:invoices) }
  end

  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:created_at) }
    it { should validate_presence_of(:updated_at) }
  end

  describe "#class methods" do
    it "can get top 5 customers with largest successful transactions" do
      expect(Customer.top_five_customers).to eq([@customer2, @customers[5], @customers[1], @customers[4], @customers[3]])
    end

    it "can get numbers of transactions" do
      expect(@customers[5].number_of_transactions).to eq(5)
      expect(@customer2.number_of_transactions).to eq(7)
      expect(@customers[6].number_of_transactions).to eq(0)
      expect(@customers[0].number_of_transactions).to eq(0)
    end

    describe '#top_merchant_customers' do
      it "returns the customers with the highest transaciton count for the merchant" do
        expect(Customer.top_merchant_customers(@merchant)).to eq([@customers[5], @customers[1], @customers[4], @customers[3], @customers[2]])
        expect(Customer.top_merchant_customers(@merchant2)).to eq([@customer2])
      end
    end
  end
end
