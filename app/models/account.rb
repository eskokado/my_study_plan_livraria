require 'iban-tools'

# Classe que representa uma conta bancária no sistema
class Account < ApplicationRecord
  # Validações
  validates :account_number,  presence: true
  validates :verifier_digit,  presence: true

  # Associações
  belongs_to :supplier

  # Validação personalizada
  validate :validate_verifier_digit

  # Valida o dígito verificador
  #
  # @return [void]
  def validate_verifier_digit
    country_code = "BR"
    bank_code = "0036"
    branch_code = "0305"

    iban = IBANTools::IBAN.new("#{country_code}#{verifier_digit}#{bank_code}#{branch_code}#{account_number}P1")
    unless IBANTools::IBAN.valid?(iban.code)
      errors.add(:verifier_digit, "is invalid")
    end
  end
end
