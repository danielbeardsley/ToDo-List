class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
  end

  def edit
    @item = Item.find(params[:id])
  end

  def create
    @item = Item.new(params[:item])

    if @item.save
      flash[:notice] = 'Item was successfully created.'
      redirect_to(@item)
    else
      render :action => "new"
    end
  end

  def update
    @item = Item.find(params[:id])

    if @item.update_attributes(params[:item])
      flash[:notice] = 'Item was successfully updated.'
      redirect_to(@item)
    else
      render :action => "edit"
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    redirect_to(items_url)
  end

  def done_it
    @item = Item.find(params[:id])
    @item.done_it

    render :action => :show
  end

  def next_thing
    @item = Item.get_next_thing
  end
end
