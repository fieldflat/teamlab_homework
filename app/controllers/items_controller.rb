class ItemsController < ApplicationController
  protect_from_forgery #CSFR対策

  def index
    @item = Item.new # 新規作成用オブジェクト
    if params[:text].nil?
      @items = Item.all.order(id: :desc)
    else
      @items = Item.where("title LIKE ?", "%#{params[:text]}%").or(Item.where("description LIKE ?", "%#{params[:text]}%"))
      @items = [] if @items.nil?
    end
    respond_to do |format|
      format.html
      # format.json { render :json => @items, handlers: 'jbuilder' }
      format.json { render 'index', formats: 'json', handlers: 'jbuilder' }
      # format.js
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
    if @item.valid?
      respond_to do |format|
        # format.html { redirect_to items_path }
        format.json { @item.save; render 'create', formats: 'json', handlers: 'jbuilder' }
        format.js 
      end
    else
      respond_to do |format|
        @error = '入力に誤りがあります．'
        # format.html { render 'index' }
        format.json { render :json => @item.errors }
        format.js
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
      format.html { redirect_to items_path }
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
      format.json { render 'search', formats: 'json', handlers: 'jbuilder' }
    end
  end

  private

    def item_params
      params.require(:item).permit(:title, :description, :price, :image)
    end


end