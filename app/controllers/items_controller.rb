class ItemsController < ApplicationController
  protect_from_forgery #CSFR対策

  def index
    @items = Item.all
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
      format.html { redirect_to items_path }
      format.json { render :json => { status: "SUCCESS", method: "deleted" } }
    end
  end

  private

    def item_params
      params.require(:item).permit(:title, :description, :price)
    end


end