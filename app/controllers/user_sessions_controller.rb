class UserSessionsController < ApplicationController
       layout 'secondary'

  def new
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])

    if @user_session.save
    	#@user_session.save do |result|
    	#if result
    	#@user_session.save

      flash[:notice] = "Successfully logged in."
      redirect_to account_url
    else
      render :action => 'index'
    end
  end
  
  def destroy
    @user_session = UserSession.find
    @user_session.destroy
    flash[:notice] = "Successfully logged out."
    redirect_to root_url
  end
end
