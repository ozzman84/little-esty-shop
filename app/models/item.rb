class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  validates :name, :description, :unit_price, :created_at, :updated_at, presence: true

  def invoice_item(inv_id)
    InvoiceItem.where(invoice_id: inv_id, item_id: id).first
  end

  def price_dollars(quantity = 1)
    '%.2f' % (unit_price * quantity / 100.0)
  end

  def unit_price_dollars
    "%.2f" % (unit_price / 100.0)
  end
end
