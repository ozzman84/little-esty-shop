require 'rails_helper'

describe 'Admin Merchants Index' do
  before :each do
    @merchant1 = Merchant.create!(
      name: 'Jason Momoa',
      created_at: "2012-03-27 14:54:09",
      updated_at: "2012-03-27 14:54:09"
    )
    @merchant2 = Merchant.create!(
      name: 'The Rock',
      status: 1,
      created_at: "2012-03-27 14:54:09",
      updated_at: "2012-03-27 14:54:09"
    )
    @merchant3 = Merchant.create!(
      name: 'Madonna',
      created_at: "2012-03-27 14:54:09",
      updated_at: "2012-03-27 14:54:09"
    )
    @merchant4 = Merchant.create!(
      name: 'Chris Hemsworth',
      status: 1,
      created_at: "2012-03-27 14:54:09",
      updated_at: "2012-03-27 14:54:09"
    )
    # @merchant5 = Merchant.create!(
    #   name: 'Chris Evans',
    #   created_at: "2012-03-27 14:54:09",
    #   updated_at: "2012-03-27 14:54:09"
    # )
    # @merchant6 = Merchant.create!(
    #   name: 'Scarlett Johansson',
    #   created_at: "2012-03-27 14:54:09",
    #   updated_at: "2012-03-27 14:54:09"
    # )
  end

  it 'lists names of all Merchants' do
    visit admin_merchants_path

    expect(page).to have_content('Jason Momoa')
    expect(page).to have_content('The Rock')
    expect(page).to have_content('Madonna')
    expect(page).to have_content('Chris Hemsworth')
    # expect(page).to have_content('Chris Evans')
    # expect(page).to have_content('Scarlett Johansson')
  end

  describe 'Admin Enable/Disable Merchants' do
    it 'can enable or disable with botton click' do
      visit admin_merchants_path

      within("##{@merchant1.id}") do
        expect(page).to have_button("Disable")
      end

      within("##{@merchant2.id}") do
        expect(page).to have_button("Enable")
      end
    end

    it 'can click enable to disable' do
      visit admin_merchants_path

      within("##{@merchant1.id}") do
        click_button "Disable"
      end
      @merchant1.reload

      expect(@merchant1.status).to eq("disable")

      within("##{@merchant1.id}") do
        expect(page).to have_button("Enable")
      end
    end
  end

  describe 'groups by status' do
    it 'groups by Enabled' do
      visit admin_merchants_path

      within("#Enabled-table") do
        expect(page).to have_content('Jason Momoa')
        expect(page).to have_content('Madonna')
        expect(page).not_to have_content('The Rock')
        expect(page).not_to have_content('Chris Hemsworth')
      end

      within("#Disabled-table") do
        expect(page).not_to have_content('Jason Momoa')
        expect(page).not_to have_content('Madonna')
        expect(page).to have_content('The Rock')
        expect(page).to have_content('Chris Hemsworth')
      end
    end
  end
end
