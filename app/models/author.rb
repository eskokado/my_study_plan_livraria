class Author < ApplicationRecord
  validates :name, presence: true
  validates :cpf, presence: true

  has_many :books

  validate :validate_cpf

  def validate_cpf
    cpf = CPF.new(self.cpf)
    unless cpf.valid?
      errors.add(:cpf, "is invalid")
    end
  end
end
