# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  layout :detect_browser


  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  helper_method :current_user  

  def index
    if params[:filter] == "Empresas"
       @results = Company.find(:all, :conditions => ['company_name ~* ?', "#{params[:query]}"], :limit => "20")
       @query = params[:search]
       if @query 
        	if params[:sort].nil?
	        @companies = Company.paginate(:page=>params[:page],:per_page=> 20,:conditions => ['company_name ~* ? AND (root = ? OR company_location_id is NULL)', "#{params[:search]}", "t"], :order => 'company_name')
        end       
       end
       respond_to do |format|
            format.js
            format.html # index.html.erb
            format.xml  { render :xml => @companies.to_xml(:only =>[:company_name, :company_phone, :updated_at, :company_city, :company_site, :company_state]) }
       end
    elsif params[:filter] == "Contactos"
       @results = Contact.find(:all, :conditions => ['name ~* ?', "#{params[:query]}"], :limit => "20")
       @query = params[:search]
       if @query 
        	if params[:sort].nil?
	        @contacts = Contact.paginate(:page=>params[:page],:per_page=> 20,:conditions => ['name ~* ?', "#{params[:search]}"], :order => 'name')
        end       
       end
       respond_to do |format|
           format.js
           format.html
           format.xml  { render :xml => @contacts.to_xml(:only =>[:id, :name, :title, :city, :department, :hierarchy]) }
       end
    elsif params[:filter] == "Servicios"
       @results = Service.find(:all, :conditions => ['name ~* ?', "#{params[:query]}"], :limit => "20")
       @query = params[:search]
       if @query 
        	if params[:sort].nil?
	        @services = Service.paginate(:page=>params[:page],:per_page=> 20,:conditions => ['name ~* ?', "#{params[:search]}"], :order => 'name')
        end       
       end
       respond_to do |format|
           format.js
           format.html
           format.xml  { render :xml => @services.to_xml(:only =>[:id, :name, :description, :contact_name, :contact_title, :contact_email, :buy, :sell, :created_at, :updated_at]) }
       end
    elsif params[:filter] == "Productos"
       @results = Product.find(:all, :conditions => ['name ~* ?', "#{params[:query]}"], :limit => "20")
       @query = params[:search]
       if @query 
        	if params[:sort].nil?
	        @services = Product.paginate(:page=>params[:page],:per_page=> 20,:conditions => ['name ~* ?', "#{params[:search]}"], :order => 'name')
        end       
       end
       respond_to do |format|
           format.js
           format.html
           format.xml  { render :xml => @services.to_xml(:only =>[:id, :name, :description, :contact_name, :contact_title, :contact_email, :buy, :sell, :created_at]) }
       end
    end
  end
  
  private  

  MOBILE_BROWSERS = ["android", "ipod", "iphone", "opera mini", "blackberry", "palm","hiptop","avantgo","plucker", "xiino","blazer","elaine", "windows ce; ppc;", "windows ce; smartphone;","windows ce; iemobile", "up.browser","up.link","mmp","symbian","smartphone", "midp","wap","vodafone","o2","pocket","kindle", "mobile","pda","psp","treo"]

  def detect_browser

    layout = selected_layout
    return layout if layout

    #agent detection takes precedence
    agent = request.env["HTTP_USER_AGENT"].downcase
    MOBILE_BROWSERS.each do |m|
      return mobile_application() if agent.match(m)
    end

    return "application"
  end

 def mobile_layout 
    return "mobile_application" 
 end

  def selected_layout
    session.inspect # force session load
    if session.has_key? "layout"
      return (session["layout"] == "mobile") ? "mobile_application" : "application"
    end
    return nil
  end

  def current_user_session  
    return @current_user_session if defined?(@current_user_session)  
    @current_user_session = UserSession.find
  end  
  
  def current_user  
    @current_user = current_user_session && current_user_session.record  
  end 

  def comany_sort_name(company)
	@company.paginate(:page=>params[:page],:per_page=> 3,:conditions => ['company_name ~* ?', $parametro], :order => 'company_name')
  end
end
