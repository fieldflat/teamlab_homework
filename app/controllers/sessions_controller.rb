class SessionsController < ApplicationController
  def new
  end

  def create
    shop = Shop.find_by(email: params[:session][:email].downcase)
    if shop && shop.authenticate(params[:session][:password])
      # ユーザーログイン後にユーザー情報のページにリダイレクトする
      log_in shop
      redirect_to shop
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
