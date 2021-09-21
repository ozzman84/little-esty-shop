require 'rails_helper'

RSpec.describe "Merchant item index" do
  describe "feature methods" do
    before :each do
      allow_any_instance_of(GithubService).to receive(:get_data).and_return("haha")
      allow_any_instance_of(GithubService).to receive(:pulls).and_return({one: 1, two: 2 })
      allow_any_instance_of(GithubService).to receive(:name).and_return({name: "little-esty-shop"})
      @merch1 = Merchant.create!(name: "Douglas Olson")
      @item1 = @merch1.items.create!(name: "Polly Pocket", description: "So pretty", unit_price: 862, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      @item2 = @merch1.items.create!(name: "Cabbage Patch Doll", description: "Cute", unit_price: 1239, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      @item3 = @merch1.items.create!(name: "Teddy Ruxpin", description: "Creepy", unit_price: 1543, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      @item4 = @merch1.items.create!(name: "Barbie", description: "Gorgeous", unit_price: 2183, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      @merch2 = Merchant.create!(name: "Sarah Carter")
      @item5 = @merch2.items.create!(name: "GI Joe", description: "Imperialism", unit_price: 743, created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    end

    it "lists all of the merchants' items' names" do
      visit merchant_items_path(@merch1)

      expect(page).to have_content(@item1.name)
      expect(page).to have_content(@item2.name)
      expect(page).to have_content(@item3.name)
      expect(page).to have_content(@item4.name)
    end

    it "doesn't list any other merchants' items" do
      visit merchant_items_path(@merch1)
      expect(page).to have_no_content(@item5.name)
    end

    it "links each item's name to its show page" do
      visit merchant_items_path(@merch1)

      expect(page).to have_link("#{@item1.name}")
      click_link "#{@item1.name}"
      expect(current_path).to eq(merchant_item_path(@merch1, @item1))

      visit merchant_items_path(@merch1)

      expect(page).to have_link("#{@item2.name}")
      click_link "#{@item2.name}"
      expect(current_path).to eq(merchant_item_path(@merch1, @item2))
    end

    it "shows the items status and button to change status" do
      item5 = @merch1.items.create!(name: "Bratz", description: "Gorgeous", unit_price: 2183, status: "enabled", created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      visit merchant_items_path(@merch1)

      within "#item-#{@item1.id}" do
        expect(page).to have_content(@item1.name)
        expect(page).to have_button("Enable")
        click_button("Enable")
        expect(page).to have_content(@item1.name)
        expect(page).to have_button("Disable")
      end

      within "#item-#{item5.id}" do
        expect(page).to have_content(item5.name)
        expect(page).to have_button("Disable")
        click_button("Disable")
        expect(page).to have_content(item5.name)
        expect(page).to have_button("Enable")
      end

    end

    it "shows items in enabled and disabled column" do
      item5 = @merch1.items.create!(name: "Bratz", description: "Gorgeous", unit_price: 2183, status: "enabled", created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
      visit merchant_items_path(@merch1)

      @item2.status = "enabled"
      within("#enabled-items") do
        expect(page).to have_content(item5.name)
        expect(page).to_not have_content(@item1.name)
      end

      within("#disabled-items") do
        expect(page).to have_content(@item1.name)
        expect(page).to_not have_content(item5.name)
      end
    end
  end

  describe "top_items" do
    before :each do
      @merch = create(:merchant)
      @items = create_list(:item, 7, merchant: @merch)
      @customer = create(:customer)
      @invoices = create_list(:invoice, 5, customer: @customer)
      @ii_1 = create(:invoice_item, invoice: @invoices[0], item: @items[1], quantity: 2, unit_price: 100)
      @ii_2 = create(:invoice_item, invoice: @invoices[0], item: @items[2], quantity: 10, unit_price: 200)
      @ii_3 = create(:invoice_item, invoice: @invoices[1], item: @items[3], quantity: 4, unit_price: 40)
      @ii_4 = create(:invoice_item, invoice: @invoices[1], item: @items[4], quantity: 12, unit_price: 30)
      @ii_5 = create(:invoice_item, invoice: @invoices[1], item: @items[5], quantity: 20, unit_price: 90)
      @ii_6 = create(:invoice_item, invoice: @invoices[2], item: @items[6], quantity: 3, unit_price: 50)
      @ii_7 = create(:invoice_item, invoice: @invoices[2], item: @items[1], quantity: 6, unit_price: 80)
      @ii_8 = create(:invoice_item, invoice: @invoices[3], item: @items[2], quantity: 10, unit_price: 75)
      @ii_9 = create(:invoice_item, invoice: @invoices[3], item: @items[2], quantity: 7, unit_price: 60)
      @ii_10 = create(:invoice_item, invoice: @invoices[4], item: @items[0], quantity: 1000, unit_price: 800)
      @trans1 = create(:transaction, invoice: @invoices[0])
      @trans2 = create(:transaction, invoice: @invoices[1])
      @trans3 = create(:transaction, invoice: @invoices[2])
      @trans4 = create(:transaction, invoice: @invoices[3])
      @trans5 = create(:failed_transaction, invoice: @invoices[3])
      @trans6 = create(:failed_transaction, invoice: @invoices[4])
    end

    it "shows a merchants top five items" do
      visit merchant_items_path(@merch)

      within("#top-items") do
        expect(page).to have_content(@items[2].name)
        expect(page).to have_content(@items[5].name)
        expect(page).to have_content(@items[1].name)
        expect(page).to have_content(@items[4].name)
        expect(page).to have_content(@items[3].name)
        expect(page).to have_no_content(@items[0].name)
        expect(page).to have_no_content(@items[6].name)
      end
    end
  end

  describe "best day" do
    before :each do
      @merch = create(:merchant)
      @items = create_list(:item, 7, merchant: @merch)
      @customer = create(:customer)
      @inv0 = create(:invoice, customer: @customer, created_at: "2014-05-10 14:53:59 UTC")
      @inv1 = create(:invoice, customer: @customer, created_at: "2016-03-27 14:53:59 UTC")
      @inv2 = create(:invoice, customer: @customer, created_at: "2012-01-06 14:53:59 UTC")
      @inv3 = create(:invoice, customer: @customer, created_at: "2012-03-27 14:53:59 UTC")
      @inv4 = create(:invoice, customer: @customer, created_at: "2010-08-03 14:53:59 UTC")
      @ii_1 = create(:invoice_item, invoice: @inv0, item: @items[1], quantity: 2, unit_price: 100)
      @ii_2 = create(:invoice_item, invoice: @inv0, item: @items[2], quantity: 10, unit_price: 200)
      @ii_3 = create(:invoice_item, invoice: @inv1, item: @items[3], quantity: 4, unit_price: 40)
      @ii_4 = create(:invoice_item, invoice: @inv1, item: @items[4], quantity: 12, unit_price: 30)
      @ii_5 = create(:invoice_item, invoice: @inv1, item: @items[5], quantity: 20, unit_price: 90)
      @ii_6 = create(:invoice_item, invoice: @inv2, item: @items[6], quantity: 3, unit_price: 50)
      @ii_7 = create(:invoice_item, invoice: @inv2, item: @items[1], quantity: 6, unit_price: 80)
      @ii_8 = create(:invoice_item, invoice: @inv3, item: @items[2], quantity: 10, unit_price: 75)
      @ii_9 = create(:invoice_item, invoice: @inv3, item: @items[2], quantity: 7, unit_price: 60)
      @ii_10 = create(:invoice_item, invoice: @inv4, item: @items[0], quantity: 1000, unit_price: 800)
      @trans1 = create(:transaction, invoice: @inv0)
      @trans2 = create(:transaction, invoice: @inv1)
      @trans3 = create(:transaction, invoice: @inv2)
      @trans4 = create(:transaction, invoice: @inv3)
      @trans5 = create(:failed_transaction, invoice: @inv3)
      @trans6 = create(:failed_transaction, invoice: @inv4)
    end

    it "displays item's best day" do
      visit merchant_items_path(@merch)

      within("#top-items") do
        expect(page).to have_content(@inv0.created_at.strftime("%m/%d/%y"))
        expect(page).to have_content(@inv1.created_at.strftime("%m/%d/%y"))
        expect(page).to have_content(@inv2.created_at.strftime("%m/%d/%y"))
        expect(page).to have_content(@inv1.created_at.strftime("%m/%d/%y"))
        expect(page).to have_content(@inv1.created_at.strftime("%m/%d/%y"))
        expect(page).to have_no_content(@inv3.created_at.strftime("%m/%d/%y"))
        expect(page).to have_no_content(@inv4.created_at.strftime("%m/%d/%y"))
      end
    end
  end
end
