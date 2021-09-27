require 'rails_helper'

RSpec.describe 'Merchant BulkDiscount Index' do
  before :each do
    @merch = create(:merchant)
    @m1_discount = @merch.bulk_discounts.create!(percent_discount: 10, threshold: 5)
    @m1_discount = @merch.bulk_discounts.create!(percent_discount: 15, threshold: 10)
    # @item1 = create(:item, merchant_id: @merch.id)
    # @item2 = create(:item, merchant_id: @merch.id)
    # @item3 = create(:item, merchant_id: @merch2.id)
    # @cust = create(:customer)
    # @invoice1 = create(:invoice, customer_id: @cust.id)
    # @inv_item1 = create(:invoice_item, invoice_id: @invoice1.id, item_id: @item1.id)
    # @inv_item2 = create(:invoice_item, invoice_id: @invoice1.id, item_id: @item2.id)
    # @inv_item3 = create(:invoice_item, invoice_id: @invoice1.id, item_id: @item3.id)
  end

  describe 'as a Merchant' do
    it 'shows all BulkDiscounts by Merchant' do
      visit merchant_bulk_discounts_path(@merch)

      @merch.bulk_discounts.each do |discount|
        expect(page).to have_content(discount.percent_discount)
        expect(page).to have_content(discount.threshold)
      end
    end

    it 'all BulkDiscounts have a link to it\'s show page' do
      visit merchant_bulk_discounts_path(@merch)

      within("discount-#{@m1_discount.id}") do
        click_link("Bulk Discount Threshold: #{@m1_discount.threshold} Bulk Discount Percentage: #{@m1_discount.percent_discount}")

        expect(current_path).to eq(merchant_bulk_discount_path(@merch.bulk_discounts, @m1_discount))
      end
    end
  end

  describe 'create a Discount' do
    it 'can create discount' do
      visit merchant_bulk_discounts_path(@merch)
      click_on('Create Discount')

      expect(current_path).to eq(new_merchant_bulk_discount_path(@merch))

      save_and_open_page
      fill_in('Percent discount', with: 20)
      fill_in('Threshold', with: 20)
      click_button('Create Discount')

      @new_m1_discount = @merchant.bulk_discounts.last

      expect(current_path).to eq(merchant_bulk_discounts_path(@merch))
      expect(page).to have_content(@new_m1_discount.percent_discount)
      expect(page).to have_content(@new_m1_discount.threshold)
      expect(page).to have_content('Bulk Discount added successfully!')
    end

    xit 'returns flash message and reloads page w/sad path' do
      visit merchant_bulk_discounts_path(@merch)
      click_on('Create Discount')

      click_button('Create Discount')

      @new_m1_discount = @merchant.bulk_discounts.last

      expect(current_path).to eq(new_merchant_bulk_discount_path(@merch))
      expect(page).not_to have_content(@new_m1_discount.percent_discount)
      expect(page).not_to have_content(@new_m1_discount.threshold)
      expect(page).to have_content('Bulk Discount Not Created: Please re-enter information.')
    end
  end
end
