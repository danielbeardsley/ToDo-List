class ListsController < ApplicationController
  def index
    @lists = List.all
  end

  def show
    @list = List.find(params[:id])
  end

  def new
    @list = List.new
    render :edit
  end

  def edit
    @list = List.find(params[:id])
  end

  def buttons
    @lists = List.all
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
