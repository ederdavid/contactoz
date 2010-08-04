# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  helper_method :current_user  

  def index
       @companies = Company.find(:all, :conditions => ['company_name LIKE ?', "%#{params[:query]}%"], :limit => "10")
       @contacts = Contact.find(:all, :conditions => ['name LIKE ?', "%#{params[:query]}%"], :limit => "10")
       respond_to do |format|
           format.js
           format.html # index.html.erb
           format.xml  { render :xml => @contacts }
       end
  end
  
  private  
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
