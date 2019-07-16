# frozen_string_literal: true

class ShopsController < ApplicationController
  def show
    @shop = Shop.find(params[:id])
  end

  def new
    @shop = Shop.new
  end

  def create
    @shop = Shop.new(shop_params)
    if @shop.save
      # 保存の成功をここで扱う。
      log_in @shop
      flash[:success] = 'Created!'
      redirect_to @shop
    else
      render 'new'
    end
  end

  private

  def shop_params
    params.require(:shop).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end
