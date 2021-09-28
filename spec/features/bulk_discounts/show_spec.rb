require 'rails_helper'

describe 'BulkDiscount Show Page' do
  before :each do
    @merch = create(:merchant)
    @discount = @merch.bulk_discounts.create!(percent_discount: 10, threshold: 5)
  end

  describe 'attributes' do
    it 'can show threshold and opercent discount' do
      visit merchant_bulk_discount_path(@merch, @discount)

      expect(page).to have_content(@discount.threshold)
      expect(page).to have_content(@discount.percent_discount)
    end
  end

  describe 'Edit' do
    it 'has an Edit button' do
      visit merchant_bulk_discount_path(@merch, @discount)

      click_link('Edit')

      fill_in('Threshold', with: 4)
      fill_in('Percent discount', with: 11)
      click_on('Update Discount')

      expect(current_path).to eq(merchant_bulk_discount_path(@discount.merchant, @discount))
      expect(page).to have_content(4)
      expect(page).to have_content(11)
      expect(page).to have_content('Bulk Discount updated successfully!')
    end

    it 'has an Edit button' do
      visit merchant_bulk_discount_path(@merch, @discount)

      click_link('Edit')

      fill_in('Threshold', with: '')
      fill_in('Percent discount', with: '')
      click_on('Update Discount')

      expect(current_path).to eq(edit_merchant_bulk_discount_path(@discount.merchant, @discount))
      expect(page).to have_content('Bulk Discount not updated: Please re-enter information.')
    end
  end
end
