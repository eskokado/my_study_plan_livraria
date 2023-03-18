class AddVerifierDigitToAccounts < ActiveRecord::Migration[7.0]
  def change
    add_column :accounts, :verifier_digit, :string
  end
end
