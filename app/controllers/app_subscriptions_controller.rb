class AppSubscriptionsController < ApplicationController
  before_filter :get_apps
  
  def show
  end
  
  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def get_apps
    @apps = Application.where(:is_public => true)
    @app_subs = Business.find(params[:id]).applications
  end
end
