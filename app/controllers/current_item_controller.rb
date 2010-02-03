class CurrentItemController < ApplicationController
  before_filter :load_item_and_list
  def get
  end

  def complete
    @current_item .complete
    flash[:notice] = "Item completed"
    redirect_to buttons_list_path
  end

protected

  def load_item_and_list
    @list = List.find(params[:list_id])
    @current_item  = @list.get_current_item
  end
end
