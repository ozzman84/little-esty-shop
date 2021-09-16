require 'rails_helper'

describe 'Admin Merchant' do
  describe 'creates new Merchant' do
    it 'can create a new Merchant' do
      visit new_admin_merchant_url

      within("#create_merchant") do
        click_link 'Create Merchant'
      end 

      fill_in 'Name', with: 'Oz World'
      click_on 'Submit'

      @merchant = Merchant.last.id

      expect(current_path).to eq(admin_merchants_path)

      within("#Disabled-table") do
        expect(page).to have_content('Oz World')
        expect(@merchant.status).to eq('disable')
      end
    end
  end
end
