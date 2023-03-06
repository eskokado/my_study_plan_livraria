class Account < ApplicationRecord
  validates :account_number,  presence: true

  belongs_to :supplier
end
