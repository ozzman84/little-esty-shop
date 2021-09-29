class InvoiceItem < ApplicationRecord
  validates :quantity, :unit_price, :status, :created_at, :updated_at, presence: true

  belongs_to :item
  belongs_to :invoice
  # has_one :merchant

  enum status: [:pending, :packaged, :shipped]

  scope :total_net_rev, -> { sum(&:adjusted_rev) }

  def self.incomplete_invoices
    invoice_ids = InvoiceItem.where('status = 0 OR status = 1').pluck(:invoice_id)
    Invoice.order(created_at: :asc).find(invoice_ids)
  end

  def self.on_merchant_invoice(invoice_id, merchant_id)
    invoice = Invoice.find(invoice_id)
    InvoiceItem.where(item_id: invoice.items.where(merchant_id: merchant_id), invoice_id: invoice_id)
               .order(:item_id)
  end

  def self.total_rev
    pennies = self.sum('unit_price * quantity')
    '%.2f' % (pennies / 100.00)
  end

  def get_item
    Item.find(item_id)
  end

  def price_dollars(mult = 1)
    '%.2f' % (unit_price * mult / 100.00)
  end

  def select_discount
    item.merchant.bulk_discounts
    .where('threshold <= ?', quantity)
    .last
  end

  def adjusted_rev
    if select_discount.nil?
      price_dollars(quantity).to_i
    else
      price_dollars(quantity).to_i * ((100 - select_discount.percent_discount) / 100.00)
    end
  end
end
