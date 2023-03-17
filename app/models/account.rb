require 'iban-tools'
class Account < ApplicationRecord
  validates :account_number,  presence: true
  validates :verifier_digit,  presence: true

  belongs_to :supplier

  validate :validate_verifier_digit

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
