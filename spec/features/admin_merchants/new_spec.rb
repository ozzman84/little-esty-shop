require 'rails_helper'

describe 'Admin Merchant' do
  before :each do
    allow_any_instance_of(GithubService).to receive(:get_data).and_return("haha")
    allow_any_instance_of(GithubService).to receive(:pulls).and_return({one: 1, two: 2 })
    allow_any_instance_of(GithubService).to receive(:name).and_return({name: "little-esty-shop"})
  end
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
        expect(@merchant.status).to eq('disabled')
      end
    end
  end
end
