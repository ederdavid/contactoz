class HomesController < ApplicationController
 layout :detect_browser


def set_layout
 session["layout"] = (params[:mobile] == "1" ? "mobile" : "normal")
 redirect_to :action => "index"
end


  # GET /homes
  # GET /homes.xml
  def index

       ##todo : check for service or products
       ##todo : search

       #if params[:search]
		#@mobile = Company.find(:all,:conditions => ['company_name like ?', "%#{params[:search]}%"], :order => 'company_name', :limit=>10)
		@mobile = Company.find(:all, :order => 'company_name', :limit=>10)

       #end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @homes }
    end
end

 # GET /companies/login
  def login

    respond_to do |format|
      format.html # new.html.erb
    end
  end

 # GET /companies/login
  def new

    respond_to do |format|
      format.html # new.html.erb
    end
  end
   
  def mobile_session 
    @user_session = UserSession.new(params[:user_session])

    if @user_session.save
      flash[:notice] = "Bienvenido"
    else
       flash[:notice] = "Contrasena y usaurio no son correctos"
    end
    session["layout"] = "mobile"

    respond_to do |format|
      format.html { redirect_to( :action => "index",  :mobile => "1") }
    end


end


end
