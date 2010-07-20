class CompaniesController < ApplicationController
    layout 'application'
    set_tab :companies

require 'fastercsv'

def export_to_csv
  #@companies = Company.find(:all)
  @companies = Array.new
  for company in params[:company]
      @companies << Company.find(company[1])
  end
if @companies.count < 5 && !current_user
  csv_string = FasterCSV.generate do |csv|
    # header row
    csv << ["id", "company_site", "company_name", "company_postcode", "company_address", "company_state", "linkedin_id", "company_phone", "company_fax", "employee_number", "revenue", "fb_id", "company_ownership", "company_overview", "activity_id", "created_at", "updated_at", "contact_id"]

    # data rows
    @companies.each do |company|
      csv << [company.id, company.company_site, company.company_name, company.company_postcode, company.company_address, company.company_state, company.linkedin_id, company.company_phone, company.company_fax, company.employee_number, company.revenue, company.fb_id, company.company_ownership, company.company_overview, company.activity_id, company.created_at, company.updated_at, company.contact_id]
    end
  end

  # send it to the browsah
  send_data csv_string,
            :type => 'text/csv; charset=iso-8859-1; header=present',
            :disposition => "attachment; filename=companies.csv"
end
end

def displayContacts
	redirect_to(:action => "index")
end

def sortByName
     @companies = Company.paginate(:page=>params[:page],:per_page=> 3, :conditions => ['company_name like ?', "%#{params[:search]}%"], :order => 'company_name')
     render :template => 'companies/index'
  end

  def sortByState
     @companies = Company.paginate(:page=>params[:page],:per_page=> 3, :conditions => ['company_name like ?', "%#{params[:search]}%"], :order => 'company_state')
     render :template => 'companies/index'
   
  end
  def sortByDateUpdated
      @companies = Company.paginate(:page=>params[:page],:per_page=> 3, :conditions => ['company_name like ?', "%#{params[:search]}%"], :order => 'updated_at')    
      render :template => 'companies/index'
  end
  def sortByNumber
     render :template => 'companies/index'
  end
  # GET /companies
  # GET /companies.xml
  def index

       @query = params[:search]
       if @query 
        	if params[:sort].nil?
			@companies = Company.paginate(:page=>params[:page],:per_page=> 3,:conditions => ['company_name like ?', "%#{params[:search]}%"], :order => 'company_name')
		end
       end

       respond_to do |format|
  	    format.html # index.html.erb
   	   format.xml  { render :xml => @companies }
       end

  end

  # GET /companies/1
  # GET /companies/1.xml
  def show
    @company = Company.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @company }
    end
  end

  # GET /companies/new
  # GET /companies/new.xml
  def new
    @company = Company.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @company }
    end
  end

  # GET /companies/1/edit
  def edit
    @company = Company.find(params[:id])
  end

  # POST /companies
  # POST /companies.xml
  def create

    if current_user
    	@action = Action.new({:points => 2, :entity_changed => "company" , :action => "create", :user_id => current_user.id })
    	@action.save
        @user = User.find(current_user.id)
        @user.points= 2 + @user.points
        @user.save


    	@company = Company.new(params[:company])

    	respond_to do |format|
      		if @company.save
        		format.html { redirect_to(@company, :notice => 'Company was successfully created.') }
        		format.xml  { render :xml => @company, :status => :created, :location => @company }
      	else
        	format.html { render :action => "new" }
        	format.xml  { render :xml => @company.errors, :status => :unprocessable_entity }
      	end
    end
    end
  end

  # PUT /companies/1
  # PUT /companies/1.xml
  def update

    if current_user
    @company = Company.find(params[:id])

    @action = Action.new({:points => 2, :entity_changed => "company" , :action => "update", :user_id => current_user.id })
    @action.save

    @user = User.find(current_user.id)
    @user.points= 2 + @user.points
    @user.save

    
    respond_to do |format|
      if @company.update_attributes(params[:company])
        format.html { redirect_to(@company, :notice => 'Company was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @company.errors, :status => :unprocessable_entity }
      end
    end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.xml
  def destroy
    @company = Company.find(params[:id])
    @company.destroy

    respond_to do |format|
      format.html { redirect_to(companies_url) }
      format.xml  { head :ok }
    end
  end
end
