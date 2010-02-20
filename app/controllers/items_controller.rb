class ItemsController < ApplicationController

  before_filter :load_item_and_list

  def index
    @items = @list.items.uncompleted
  end

  def show
  end

  def new
    @item = @list.items.new
  end

  def edit
  end

  def create
    @item = @list.items.new(params[:item])

    if @item.save
      flash[:notice] = 'Item was successfully created.'
      redirect_to buttons_lists_path
    else
      render :action => "new"
    end
  end

  def update
    if @item.update_attributes(params[:item])
      flash[:notice] = 'Item was successfully updated.'
      redirect_to(@item)
    else
      render :action => "edit"
    end
  end

  def destroy
    @list = @item.list
    @item.destroy

    redirect_to(list_items_path(@list.id))
  end

  private
  def load_item_and_list
    @item = Item.find(params[:id]) if params[:id]
    @list = List.find(params[:list_id]) if params[:list_id]
  end
end
