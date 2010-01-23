class ListsController < ApplicationController
  def index
    @lists = List.all
  end

  def show
    @list = List.find(params[:id])
  end

  def new
    @list = List.new
  end

  def edit
    @list = List.find(params[:id])
  end

  def create
    @list = List.new(params[:list])

    if @list.save
      flash[:notice] = 'List was successfully created.'
      redirect_to(@list)
    else
      render :action => "new"
    end
  end

  def current_item
     @list = List.find(params[:id])
     @item = @list.get_current_item
  end

  def current_item_completed
    if request.post?
      @list = List.find(params[:id])
      item = @list.complete_current_item
      flash[:notice] = "#{item} completed"
    end
    redirect_to lists_url
  end

  def update
    @list = List.find(params[:id])

    if @list.update_attributes(params[:list])
      flash[:notice] = 'List was successfully updated.'
      redirect_to(@list)
    else
      render :action => "edit"
    end
  end

  def destroy
    @list = List.find(params[:id])
    @list.destroy

    redirect_to(lists_url)
  end
end
