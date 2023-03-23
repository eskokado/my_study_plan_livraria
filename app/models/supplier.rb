class Supplier < ApplicationRecord
  validates :name,  presence: true
  validates :cnpj, presence: true

  has_many :parts

  has_one :account

  validate :validate_cnpj

  def validate_cnpj
    cnpj = CNPJ.new(self.cnpj)
    unless cnpj.valid?
      errors.add(:cnpj, "is invalid")
    end
  end

  def self.supplier_with_authors_and_books(supplier_id)
    joins(parts: { book: :author })
      .preload(parts: { book: :author })
      .find(supplier_id)
  end
end
