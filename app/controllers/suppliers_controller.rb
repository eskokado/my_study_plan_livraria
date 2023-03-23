require 'cpf_cnpj'
class SuppliersController < ApplicationController
  def index
    if params[:author_name]
      @suppliers = Supplier.joins(parts: { book: :author }).where(authors: { name: params[:author_name] }).select("*").distinct
    else
      if params[:account_number].present?
        @suppliers = Supplier.joins(:account).where(accounts: { account_number: params[:account_number] })
      else
        name = params[:name].present? ? params[:name] : ""
        @suppliers = Supplier.where("name LIKE ?", "%#{name}%")
      end
    end

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
