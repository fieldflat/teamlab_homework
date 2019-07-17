# frozen_string_literal: true

class ShopsController < ApplicationController
  before_action :correct_shop?, only: [:show]

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

  def correct_shop?
    @shop = Shop.find_by(id: params[:id])
    unless @shop == current_shop
      flash[:danger] = '権限がありません'
      redirect_to items_path
    end
  end
end
