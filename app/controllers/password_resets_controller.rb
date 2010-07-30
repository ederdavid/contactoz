class PasswordResetsController < ApplicationController
       layout 'secondary'
 

  # Method from: http://github.com/binarylogic/authlogic_example/blob/master/app/controllers/application_controller.rb
  #before_filter :require_no_user
  before_filter :load_user_using_perishable_token, :only => [ :edit, :update ]

  def new
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user
      @user.deliver_password_reset_instructions!
      flash[:notice] = "Instructions to reset your password have been emailed to you!"
      redirect_to root_path
    else
      flash[:notice] = "No user was found with email address #{params[:email]}!"
      render :action => :new
    end
  end

  def edit
  end

  def update
    @user.update_attribute(:password , params[:password])
    if @user.save
      flash[:notice] = "Your password was successfully updated!"
      redirect_to @user
    else
      render :action => :edit
    end
  end


  private

  def load_user_using_perishable_token
    @user = User.find_using_perishable_token(params[:id])
    unless @user
      flash[:notice] = "We're sorry, but we could not locate your account!"
      redirect_to root_url
    end
  end
end
