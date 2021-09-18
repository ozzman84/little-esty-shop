class Merchant < ApplicationRecord
  has_many :items
  validates :name, presence: true

  enum status: [:disabled, :enabled]

  def all_invoices
    Invoice.joins(:items).where('items.merchant_id = ?', id).uniq
  end
end
