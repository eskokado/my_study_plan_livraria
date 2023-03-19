require 'cpf_cnpj'
class SuppliersController < ApplicationController
  def index
    name = params[:name].present? ? params[:name] : ""
    @suppliers = Supplier.where("name LIKE ?", "%#{name}%")

    render json: @suppliers
  end
  def create
    @supplier = Supplier.new(supplier_params)
    @account = @supplier.build_account(account_params)

    if @supplier.valid? && @account.valid? && @supplier.save && @account.save
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
    params.require(:account).permit(:account_number, :verifier_digit)
  end

end
