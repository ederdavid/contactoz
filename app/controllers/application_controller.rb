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
	if params[:type] == "companies"
		@companies = Company.find(:all, :conditions => ['company_name LIKE ?', "%#{params[:query]}%"], :limit => "20")
	end
	if params[:type] == "contacts"
		@contacts = Contact.find(:all, :conditions => ['name LIKE ?', "%#{params[:query]}%"], :limit => "20")
	end
	if params[:type] == "products"
	end
	if params[:type] == "services"
	end
	if params[:type] == "all"
		@companies = Company.find(:all, :conditions => ['company_name LIKE ?', "%#{params[:query]}%"], :limit => "10")
		@contacts = Contact.find(:all, :conditions => ['name LIKE ?', "%#{params[:query]}%"], :limit => "10")
	end
	respond_to do |format|
           format.js
           format.html # index.html.erb
           format.xml  { render :xml => @contacts }
       end
  end
  
  private  

  MOBILE_BROWSERS = ["android", "ipod", "iphone", "opera mini", "blackberry", "palm","hiptop","avantgo","plucker", "xiino","blazer","elaine", "windows ce; ppc;", "windows ce; smartphone;","windows ce; iemobile", "up.browser","up.link","mmp","symbian","smartphone", "midp","wap","vodafone","o2","pocket","kindle", "mobile","pda","psp","treo"]

  def detect_browser

    #agent detection takes precedence
    agent = request.env["HTTP_USER_AGENT"].downcase
    MOBILE_BROWSERS.each do |m|
      return mobile_application() if agent.match(m)
    end

    layout = selected_layout
    return layout if layout

    return "application"
  end

 def mobile_layout 
    return "mobile_application" 
 end

  def selected_layout
    session.inspect # force session load
    if session.has_key? "layout"
      return (session["layout"] == "mobile") ? 
        "mobile_application" : "application"
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
	@company.paginate(:page=>params[:page],:per_page=> 3,:conditions => ['company_name like ?', $parametro], :order => 'company_name')
  end
end
