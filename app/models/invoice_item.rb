class InvoiceItem < ApplicationRecord
  validates :quantity, :unit_price, :status, :created_at, :updated_at, presence: true

  belongs_to :item
  belongs_to :invoice

  enum status: [:pending, :packaged, :shipped]

  def self.incomplete_invoices
    invoice_ids = InvoiceItem.where("status = 0 OR status = 1").pluck(:invoice_id)
    Invoice.order(created_at: :asc).find(invoice_ids)
  end
end
