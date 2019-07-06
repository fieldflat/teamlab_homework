class ItemsController < ApplicationController
  protect_from_forgery #CSFR対策

  def index
    @item = Item.new # 新規作成用オブジェクト
    @items = Item.all.order(id: :desc)
    respond_to do |format|
      format.html
      format.json { render :json => @items }
    end
  end

  def show
    @item = Item.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render :json => @item }
    end
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      respond_to do |format|
        # format.html { redirect_to items_path }
        format.json { render :json => @item }
        format.js
      end
    else
      respond_to do |format|
        format.html { redirect_to root_path }
        format.json { render :json => @item.errors }
      end
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      respond_to do |format|
        format.html { redirect_to item_path(@item) }
        format.json { render :json => @item }
      end
    else
      respond_to do |format|
        format.html { redirect_to root_path }
        format.json { render :json => @item.errors }
      end
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    respond_to do |format|
      # format.html { redirect_to items_path }
      format.json { render :json => { status: "SUCCESS", method: "deleted" } }
      format.js
    end
  end

  def search
    @item = Item.new # 新規作成用オブジェクト
    @items = Item.where("title LIKE ?", "%#{params[:text]}%").or(Item.where("description LIKE ?", "%#{params[:text]}%"))
    puts @items
    respond_to do |format|
      format.html { render 'index' }
      format.json { render :json => @items }
    end
  end

  private

    def item_params
      params.require(:item).permit(:title, :description, :price, :image)
    end


end