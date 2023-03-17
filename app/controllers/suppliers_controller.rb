class SuppliersController < ApplicationController
  def create
    @supplier = Supplier.new(supplier_params)
    @account = @supplier.build_account(account_params)

    if @supplier.save && @account.save
      render json: { supplier: @supplier, account: @account }, status: :created
    else
      render json: { errors: @supplier.errors.messages.merge(@account.errors.messages) }, status: :unprocessable_entity
    end
  end

  private

  def supplier_params
    params.require(:supplier).permit(:name, :cnpj)
  end

  def account_params
    params.require(:account).permit(:account_number)
  end
end
