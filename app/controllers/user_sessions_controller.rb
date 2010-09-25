class UserSessionsController < ApplicationController
       layout 'secondary'

  def new
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])

    if @user_session.save
      flash[:notice] = "Bienvenido" 
    else
       flash[:notice] = "Contrasena y usaurio no son correctos"
    end

       respond_to do |format|
                        format.html { account_url }
                        format.js 
       end
  end
  
  def destroy
    @user_session = UserSession.find
    @user_session.destroy
    flash[:notice] = "Successfully logged out."
    redirect_to root_url
  end
end
