# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def buttons_page
    {:controller => :lists, :action => :buttons}
  end
end
