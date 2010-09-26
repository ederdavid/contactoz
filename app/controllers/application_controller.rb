# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

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

MOBILE_USER_AGENTS =  'palm|blackberry|nokia|phone|midp|mobi|symbian|chtml|ericsson|minimo|' +
                          'audiovox|motorola|samsung|telit|upg1|windows ce|ucweb|astel|plucker|' +
                          'x320|x240|j2me|sgh|portable|sprint|docomo|kddi|softbank|android|mmp|' +
                          'pdxgw|netfront|xiino|vodafone|portalmmm|sagem|mot-|sie-|ipod|up\\.b|' +
                          'webos|amoi|novarra|cdm|alcatel|pocket|ipad|iphone|mobileexplorer|' +
                          'mobile'
def mobile_device?
  if session[:mobile_param]
    session[:mobile_param] == "1"
  else
   #request.user_agent =~ /Mobile|webOS/
   request.user_agent.to_s.downcase =~ Regexp.new(MOBILE_USER_AGENTS)
  end
end
helper_method :mobile_device?

def prepare_for_mobile
  session[:mobile_param] = params[:mobile] if params[:mobile]
  request.format = :mobile if mobile_device?
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
