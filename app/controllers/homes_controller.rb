class HomesController < ApplicationController
 layout :detect_browser


def set_layout
 session["layout"] = (params[:mobile] == "1" ? "mobile" : "normal")
 redirect_to :action => "index"
end

  def dataUpdated
    @Company = Company.find(:first, :order => "updated_at DESC")
    if @Company
	    if $CompanyUpdatedAt == @Company.updated_at
		@Company = nil
	    else
		$CompanyUpdatedAt = @Company.updated_at
	    end
    end
    @Contact = Contact.find(:first, :order => "updated_at DESC")
    if @Contact
	    if $ContactUpdatedAt == @Contact.updated_at
		@Contact = nil
	    else
		$ContactUpdatedAt = @Contact.updated_at
	    end
    end
    @data = ""
    @message = " acaba de actualizarse. </br>"
    if @Company	
       @Company = @Company.company_name
       @data = "#{@data}\r\n#{@Company}\r\n#{@message}\r\n"
    end
    if @Contact
       @Contact = @Contact.name
       @data = "#{@data}\r\n#{@Contact}\r\n#{@message}\r\n"
    end
    render :text => @data
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




end
