class Admin::DashboardController < ApplicationController
  def index
    @top_five = Customer.all.top_five_customers
  end
end
