class BetaSignupController < ApplicationController
  skip_before_filter :authenticate_user!
  
  def create
    BetaSignup.create!(params[:beta_signup])
    
    respond_to do |format|
      format.js
    end
  end
end
