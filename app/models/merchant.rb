class Merchant < ApplicationRecord
  has_many :items
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

  def enabled_items
    items.where(status: 'enabled')
  end

  def disabled_items
    items.where(status: 'disabled')
  end
end
