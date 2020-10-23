class Api::V1::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    if !Merchant.exists?(params[:id])
      render :status => 404
    else
      render json: MerchantSerializer.new(Merchant.find(params[:id]))
    end
  end

  def create
    Merchant.reset_primary_keys
    new_merchant = Merchant.new(merchant_params)
    render json: MerchantSerializer.new(new_merchant) if new_merchant.save
  end

  def destroy
    Merchant.destroy(params[:id])
    head :no_content
  end

  def update
    render json: MerchantSerializer.new(Merchant.update(params[:id], merchant_params))
  end

  private

  def merchant_params
    params.permit(:name, :created_at, :updated_at)
  end
end
