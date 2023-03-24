# Classe que representa um autor no sistema
class Author < ApplicationRecord
  # Validações
  validates :name, presence: true
  validates :cpf, presence: true

  # Associações
  has_many :books

  # Validação personalizada
  validate :validate_cpf

  # Valida o campo CPF
  #
  # @return [void]
  def validate_cpf
    cpf = CPF.new(self.cpf)
    unless cpf.valid?
      errors.add(:cpf, "is invalid")
    end
  end
end
