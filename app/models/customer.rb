class Customer < ApplicationRecord
  validates :first_name, :last_name, :created_at, :updated_at, presence: true

  has_many :invoices
  has_many :transactions, through: :invoices

  def self.top_five_customers
    joins(:transactions).where("transactions.result = ?", 1)
                        .group(:id)
                        .select("customers.*, count('transactions.result') as trans_count")
                        .order(trans_count: :desc)
                        .limit(5)
  end
end
