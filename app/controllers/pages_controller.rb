class PagesController < ApplicationController

  def home
    redirect_to recipes_path if logged_in?  # uses our custom method in application_controller.
  end

end
