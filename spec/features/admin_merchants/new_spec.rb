require 'rails_helper'

describe 'Admin Merchant' do
  describe 'creates new Merchant' do
    it 'can create a new Merchant' do
      visit admin_merchants_url

      within("#create-merchant") do
        click_link 'Create Merchant'
      end

      fill_in 'Name', with: 'Oz World'
      click_on 'Create Merchant'

      @merchant = Merchant.last

      expect(current_path).to eq(admin_merchants_path)

      within("##{@merchant.id}") do
        expect(page).to have_content('Oz World')
        expect(@merchant.status).to eq('enable')
      end
    end
  end
end
