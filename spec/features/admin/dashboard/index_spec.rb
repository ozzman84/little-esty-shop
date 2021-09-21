require "rails_helper"

RSpec.describe "Admin Dashboard Index Page" do
  before :each do
    allow_any_instance_of(GithubService).to receive(:get_data).and_return("haha")
    allow_any_instance_of(GithubService).to receive(:pulls).and_return({one: 1, two: 2 })
    allow_any_instance_of(GithubService).to receive(:name).and_return({name: "little-esty-shop"})
    @joey = Customer.create!(first_name: "Joey", last_name: "Ondricka", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC")
    @cecelia = Customer.create!(first_name: "Cecelia", last_name: "Osinski", created_at: "2012-03-27 14:54:10 UTC", updated_at: "2012-03-27 14:54:10 UTC")
    @mariah = Customer.create!(first_name: "Mariah", last_name: "Toy", created_at: "2012-03-27 14:54:10 UTC", updated_at: "2012-03-27 14:54:10 UTC")
    @donna = Customer.create!(first_name: "Donna", last_name: "Dumdooko", created_at: "2012-03-27 14:54:10 UTC", updated_at: "2012-03-27 14:54:10 UTC")
    @christ = Customer.create!(first_name: "Christ", last_name: "Hough", created_at: "2012-03-27 14:54:10 UTC", updated_at: "2012-03-27 14:54:10 UTC")
    @amy = Customer.create!(first_name: "Amy", last_name: "Hollerway", created_at: "2012-03-27 14:54:10 UTC", updated_at: "2012-03-27 14:54:10 UTC")

    @invoice_1 = @joey.invoices.create!(customer_id: 1, status: "completed", created_at: "2012-03-13 16:54:10 UTC", updated_at: "2012-03-25 09:54:09 UTC")
    @invoice_2 = @cecelia.invoices.create!(customer_id: 2, status: "completed", created_at: "2012-03-27 12:54:10 UTC", updated_at: "2012-03-31 16:54:10 UTC")
    @invoice_3 = @mariah.invoices.create!(customer_id: 3, status: "in progress", created_at: "2012-03-06 21:54:10 UTC", updated_at: "2012-03-12 21:54:10 UTC")
    @invoice_4 = @donna.invoices.create!(customer_id: 4, status: "completed", created_at: "2012-03-15 16:54:10 UTC", updated_at: "2012-03-25 09:54:09 UTC")
    @invoice_5 = @christ.invoices.create!(customer_id: 5, status: "completed", created_at: "2012-03-10 12:54:10 UTC", updated_at: "2012-03-13 16:54:10 UTC")
    @invoice_6 = @amy.invoices.create!(customer_id: 6, status: "in progress", created_at: "2012-03-18 21:54:10 UTC", updated_at: "2012-03-31 21:54:10 UTC")

    @zara = Merchant.create!(name: "Zara")
    @forever_21 = Merchant.create!(name: "Forever 21")

    @hat = @zara.items.create!(name: "Hat", description: "Sun hat", unit_price: 1200, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @socks = @zara.items.create!(name: "Socks", description: "Heart pattern socks", unit_price: 600, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @tank_top = @zara.items.create!(name: "Tank top", description: "Work out tank top", unit_price: 1800, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @shorts = @forever_21.items.create!(name: "Shorts", description: "Black denim shorts", unit_price: 4000, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @dress = @forever_21.items.create!(name: "Dress", description: "Sun dress", unit_price: 2900, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @skirt = @forever_21.items.create!(name: "Skirt", description: "Polka dot skirt", unit_price: 2500, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")

    @invoice_item_1 = InvoiceItem.create!(item: @hat, invoice: @invoice_1, quantity: 2, unit_price: 1200, status: "pending", created_at: "2012-03-13 16:54:10 UTC", updated_at: "2012-03-25 09:54:09 UTC")
    @invoice_item_2 = InvoiceItem.create!(item: @socks, invoice: @invoice_1 , quantity: 2, unit_price: 600, status: "pending", created_at: "2012-03-13 16:54:10 UTC", updated_at: "2012-03-25 09:54:09 UTC")
    @invoice_item_3 = InvoiceItem.create!(item: @tank_top , invoice: @invoice_2, quantity: 1 , unit_price: 1800, status: "shipped", created_at: "2012-03-27 12:54:10 UTC", updated_at: "2012-03-31 16:54:10 UTC")
    @invoice_item_4 = InvoiceItem.create!(item: @shorts, invoice: @invoice_3  , quantity: 1 , unit_price: 4000, status: "shipped", created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @invoice_item_5 = InvoiceItem.create!(item: @dress, invoice: @invoice_3, quantity: 5, unit_price: 2900, status: "packaged", created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @invoice_item_6 = InvoiceItem.create!(item: @skirt, invoice: @invoice_3, quantity: 3, unit_price: 2500, status: "packaged", created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @invoice_item_7 = InvoiceItem.create!(item: @tank_top , invoice: @invoice_4, quantity: 1 , unit_price: 1800, status: "shipped", created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @invoice_item_8 = InvoiceItem.create!(item: @shorts, invoice: @invoice_5  , quantity: 1 , unit_price: 4000, status: "shipped", created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @invoice_item_9 = InvoiceItem.create!(item: @dress, invoice: @invoice_5, quantity: 5, unit_price: 2900, status: "packaged", created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    @invoice_item_10 = InvoiceItem.create!(item: @skirt, invoice: @invoice_6, quantity: 3, unit_price: 2500, status: "packaged", created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")

    Transaction.create!(invoice_id: @invoice_1.id, credit_card_number: "4654405418249632", result: "success", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC")
    Transaction.create!(invoice_id: @invoice_2.id, credit_card_number: "4580251236515201", result: "success", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC")
    Transaction.create!(invoice_id: @invoice_3.id, credit_card_number: "4354495077693036", result: "success", created_at: "2012-03-27 14:54:10 UTC", updated_at: "2012-03-27 14:54:10 UTC")
    Transaction.create!(invoice_id: @invoice_4.id, credit_card_number: "4515551623735607", result: "success", created_at: "2012-03-27 14:54:10 UTC", updated_at: "2012-03-27 14:54:10 UTC")
    Transaction.create!(invoice_id: @invoice_5.id, credit_card_number: "4844518708741275", result: "success", created_at: "2012-03-27 14:54:10 UTC", updated_at: "2012-03-27 14:54:10 UTC")
    Transaction.create!(invoice_id: @invoice_6.id, credit_card_number: "4203696133194408", result: "success", created_at: "2012-03-27 14:54:10 UTC", updated_at: "2012-03-27 14:54:10 UTC")
  end

  describe "Dashboard" do
    it "displays a header stating Admin Dashboard" do
      visit "/admin"

      expect(page).to have_content("Admin Dashboard")
    end

    it "has a link to admin merchant index" do
      visit "/admin"

      expect(page).to have_link("Merchants")
    end

    it "has a link to admin invoice index" do
      visit "/admin"

      expect(page).to have_link("Invoices")
    end

    it "has a link to go back to home" do
      visit "/admin"

      expect(page).to have_link("Home")
    end
  end

  describe "Statistics" do
    it "displays the names of the top 5 customers with largest number of successful transactions" do
      visit "/admin"

      expect(page).to have_content("Top Customers")

      within("#top_five") do
        expect(@joey.first_name).to appear_before(@cecelia.first_name)
        expect(@cecelia.first_name).to appear_before(@donna.first_name)
        expect(@mariah.first_name).to appear_before(@christ.first_name)
      end
    end

    it "displays the number of successful transactions of each customer's name" do
      visit "/admin"

      expect(page).to have_content(@joey.number_of_transactions)
      expect(page).to have_content(@cecelia.number_of_transactions)
      expect(page).to have_content(@mariah.number_of_transactions)
      expect(page).to have_content(@donna.number_of_transactions)
      expect(page).to have_content(@christ.number_of_transactions)
    end
  end

  describe "Incomplete Invoices" do
    it "has a name 'Incomplete Invoices'" do
      visit "/admin"

      expect(page).to have_content("Incomplete Invoices")
    end

    it "displays links of incomplete invoice ids that have items that have not been shipped" do
      visit "/admin"

      within("#invoices") do
        expect(page).to have_link("Invoice ##{@invoice_1.id}")
        expect(page).to have_link("Invoice ##{@invoice_3.id}")
        expect(page).to have_link("Invoice ##{@invoice_5.id}")
        expect(page).to have_link("Invoice ##{@invoice_6.id}")
      end

      click_on "Invoice ##{@invoice_1.id}"

      expect(current_path).to eq(admin_invoice_path(@invoice_1))
    end

    it "displays when invoices are created at in first created order" do
      visit "/admin"

      within("#invoices") do
        expect(page).to have_content("Created at: Saturday, March 10, 2012")
        # expect(@invoice_3.created_at).to appear_before(@invoice_5.created_at)
      end
    end
  end
end
