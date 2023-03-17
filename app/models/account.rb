require 'iban-tools'
class Account < ApplicationRecord
  validates :account_number,  presence: true
  validates :verifier_digit,  presence: true

  belongs_to :supplier
end
