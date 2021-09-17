require 'rails_helper'

RSpec.describe 'Admin Merchant Index' do
  before :each do
    @customer1 = Customer.create!(first_name: 'John', last_name: 'Smith', created_at: "2012-03-27 14:53:59", updated_at: "2012-03-27 14:53:59")
    @customer2 = Customer.create!(first_name: 'Steve', last_name: 'Dobson', created_at: "2012-03-27 14:53:59", updated_at: "2012-03-27 14:53:59")
    @customer3 = Customer.create!(first_name: 'Melenie', last_name: 'Kelly', created_at: "2012-03-27 14:53:59", updated_at: "2012-03-27 14:53:59")
    @customer4 = Customer.create!(first_name: 'Rachel', last_name: 'Jonas', created_at: "2012-03-27 14:53:59", updated_at: "2012-03-27 14:53:59")
    @customer5 = Customer.create!(first_name: 'Adam', last_name: 'Tally', created_at: "2012-03-27 14:53:59", updated_at: "2012-03-27 14:53:59")
    @customer6 = Customer.create!(first_name: 'George', last_name: 'Bratz', created_at: "2012-03-27 14:53:59", updated_at: "2012-03-27 14:53:59")
  end

  describe 'Admin Dashboard' do
    xit 'indicates the page is admin dashboard' do
      visit '/admin'

      expect(page).to have_content("Admin Dashboard")
    end

    xit 'shows links to merchants index & invoices index' do
      visit '/admin'

      expect(page).to have_link('List of Merchants')
      expect(page).to have_link('List of Invoices')
    end


    xit 'can display the names of the top 5 customers' do
      visit '/admin'
    end
  end
end
