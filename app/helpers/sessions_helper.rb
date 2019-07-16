# frozen_string_literal: true

module SessionsHelper
  # 渡されたユーザーでログインする
  def log_in(shop)
    session[:shop_id] = shop.id
  end

  # 現在ログイン中のユーザーを返す (いる場合)
  def current_shop
    @current_shop ||= Shop.find_by(id: session[:shop_id]) if session[:shop_id]
  end

  # ユーザーがログインしていればtrue、その他ならfalseを返す
  def logged_in?
    !current_shop.nil?
  end

  # 現在のユーザーをログアウトする
  def log_out
    session.delete(:shop_id)
    @current_shop = nil
  end
end
