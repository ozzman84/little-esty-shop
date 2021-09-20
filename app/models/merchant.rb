class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices, through: :items
  validates :name, presence: true

  enum status: [:disabled, :enabled]

  def all_invoices
    Invoice.joins(:items).where('items.merchant_id = ?', id).uniq
  end

  def top_5_by_rev
    joins([invoices: :invoice_items], [invoices: :transactions])
    .group(:id)
    .select('invoice_id, SUM(unit_price*quantity) AS total_price')
    .group(:invoice_id)
    .having('transaction.status = ?', 1)
    # .select('invoice_id, SUM(unit_price*quantity) AS total_price' FROM invoice_items group by invoice_id;
  end
end
