class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoices, through: :items
  validates :name, presence: true

  enum status: [:disabled, :enabled]

  def all_invoices
    Invoice.joins(:items).where('items.merchant_id = ?', id).uniq
  end

  def ready_to_ship
    items.select(:name, 'invoice_items.invoice_id', 'invoice_items.created_at AS invoice_created')
         .joins(:invoice_items)
         .where.not('invoice_items.status = ?', 2)
         .order("invoice_created")
  end

  def self.top_5_by_rev
    joins(invoices: :transactions)
    .where('transactions.result = ?', 1)
    .select('merchants.*, SUM(invoice_items.unit_price*invoice_items.quantity) AS total_rev')
    .group(:id)
    .order(total_rev: :desc)
    .limit(5)
  end
end
