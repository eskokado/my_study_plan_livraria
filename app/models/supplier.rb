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
end
