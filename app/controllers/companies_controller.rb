class CompaniesController < ApplicationController
    layout 'standard'
    set_tab :companies

require 'fastercsv'


def export_to_csv
  @companies = Company.find(:all)

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
            :disposition => "attachment; filename=users.csv"
end

def displayContacts
	redirect_to(:action => "index")
end

def sortByName
     $name = "1"
	$state = nil
	$date = nil
	$number = nil
     redirect_to(:action => "index")
  end
  def sortByState
     $state = "1"
	$name = nil
	$date = nil
	$number = nil
     redirect_to(:action => "index")
  end
  def sortByDateUpdated
     $date = "1"
	$name = nil
	$state = nil
	$number = nil
     redirect_to(:action => "index")
  end
  def sortByNumber
     $number = "1"
	$name = nil
	$state = nil
	$date = nil
     redirect_to(:action => "index")
  end
  # GET /companies
  # GET /companies.xml
  def index
	if !$allContacts
		if params[:search]

		$companies_search = Company.paginate(:page=>params[:page],:per_page=> 3,:conditions => ['company_name like ?', "%#{params[:search]}%"], :order => 'company_name')
		$parametro = "%#{params[:search]}%"
		else
		   $companies_search = nil
		end
		if $number
		$companies_search = Company.paginate(:page=>params[:page],:per_page=> 3,:conditions => ['company_name like ?', $parametro], :order => 'contact_id')
		end
		if $name
		$companies_search = Company.paginate(:page=>params[:page],:per_page=> 3,:conditions => ['company_name like ?', $parametro], :order => 'company_name')
		end
		if $state
		$companies_search = Company.paginate(:page=>params[:page],:per_page=> 3,:conditions => ['company_name like ?', $parametro], :order => 'company_state')
		end
		if $date
		$companies_search = Company.paginate(:page=>params[:page],:per_page=> 3,:conditions => ['company_name like ?', $parametro], :order => 'updated_at')
		end
	    @companies = Company.all

	    respond_to do |format|
	      format.html # index.html.erb
	      format.xml  { render :xml => @companies }
	    end
	else
		redirect_to(:controller => "contacts", :action => "index")
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
