class UserProfileController < ApplicationController
  before_filter :get_user, :only => [:show, :index, :edit, :update]
  before_filter :set_menu_visibility, :only => [:new, :create]
      
  def index
    render :show
  end
    
  def show
  end
  
  def edit
  end

  def update
    @profile.update_attributes(params[:user_profile])
    
    if (@profile.save)
      redirect_to new_business_path
    else
      render :edit
    end
  end
  
  private
  
  def get_user
    if params[:id] == nil || current_user.id == params[:id]
      @user = current_user
      @profile = current_user.profile
    else
      @user = User.find(params[:id])
      @profile = @user.profile
    end
  end
end
