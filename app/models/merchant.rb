class Merchant < ApplicationRecord
  has_many :items
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

  def top_5_by_rev
    joins([invoices: :invoice_items], [invoices: :transactions])
    .group(:id)
    .select('invoice_id, SUM(unit_price*quantity) AS total_price')
    .group(:invoice_id)
    .having('transaction.status = ?', 1)
    # .select('invoice_id, SUM(unit_price*quantity) AS total_price' FROM invoice_items group by invoice_id;
  end 
end
