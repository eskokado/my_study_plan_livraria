class Supplier < ApplicationRecord
  validates :name,  presence: true
  validates :cnpj, presence: true
  validate :valid_cnpj?

  has_many :parts

  has_one :account

  private
  def valid_cnpj?
    cnpj = CNPJ.new(self.cnpj)
    cnpj.valid?
  end
end
