class CompaniesController < ApplicationController
    require 'text/levenshtein'
    require 'fastercsv'
    layout 'application'
    $global_page = 20


def clInCNil
    @companies = Company.find(:all, :conditions => ["company_location_id IS NOT NULL"])
    for i in @companies
        @i = i
        @i.company_location_id = nil
        @i.save
    end
end

def clNil
    @companiesLocations = CompanyLocation.all
    for i in @companiesLocations
        @companiesLocations.destroy
    end
end


def self.root
    @companies= Company.all
    for i in @companies
        @i = i
        @companyLocation = CompanyLocation.find_by_company_id(i.id)
        if @companyLocation != nil
            @i.root = true
            @i.save
        else
            @i.root = false
            @i.save
        end
    end
end


def clean
    @fd = File.open("/home/mauricio/contacto/MexicoJSON")
    @JSONMexicoInfo = ActiveSupport::JSON.decode(@fd.read)
    @companies = Company.all
    @companiesCount = Company.count
    @companyLocationCount = CompanyLocation.count
    for i in @companies
        @jcompanies = Company.find(:all, :conditions => ["company_name like ? AND company_location_id IS NULL", "%#{i.company_name}%"], :limit => 30)#@companiesCount)
        if i != nil && @jcompanies != nil
            for j in @jcompanies
                @name = j.company_name
                if @name == nil
                    @name = ""
                end
                #filtro de estado y municipio
                for estado in @JSONMexicoInfo.keys
                    @name = @name.sub(estado, "").strip()
                    for municipio in @JSONMexicoInfo[estado]
                        @name = @name.sub(municipio, "").strip()
                    end
                end
                #filtro de region
                @name = @name.sub(/(DEL)? (NORTE|SUR|ESTE|OESTE|NORESTE|SURESTE|NOROESTE|SUROESTE|CENTRO)/, "").strip()
                #filtro de SA DE CV
                @name = @name.sub(/S(.?)A(.?) DE C(.?)V(.?)/, "").strip()
                if i.company_name != nil && @name != ""
                    if i.company_name.length <= (@name.length + 4) 
                        @stringDistance = Text::Levenshtein.distance(i.company_name, @name)
                        if (@name.length*0.2) < (Float(@stringDistance)/Float(@name.length))*@name.length
                            @cl = CompanyLocation.find_by_company_id(i.id)
                            if @cl == nil
                                @cl = CompanyLocation.new
                                @cl.company_id = i.id
                                @cl.city = j.company_city
                                @cl.address = j.company_address
                                @cl.state = j.company_state
                                @cl.phone_number = j.company_phone
                                @cl.save
                                @i = i
                                @i.company_location_id = @cl.id
                                @i.save
                            end
                            @cl = CompanyLocation.new
                            @cl.company_id = i.id
                            @cl.city = j.company_city
                            @cl.address = j.company_address
                            @cl.state = j.company_state
                            @cl.phone_number = j.company_phone
                            @cl.save
                            @j = j
                            @j.company_location_id = @cl.id
                            @j.save                                
                        end
                    end
                end
            end
        end
    end
end

def set_layout
 session["layout"] = (params[:mobile] == "1" ? "mobile" : "normal")
 redirect_to :action => "index"
end

def export_to_csv
  if params[:all]
	@companies = Company.find(:all)
  else
	  @companies = Array.new
	  for company in params[:company]
	      if !company[1]
		@companies << Company.find(company)
	      else
		@companies << Company.find(company[1])
	      end
	  end
  end
#if @companies.count < 5 && !current_user
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
#end
end

def csv_import
  
   $KCODE = 'u'  
   require 'iconv'

   #save temp file
   path = File.join('public/data/', 'file.csv' )
   path2 = File.open(path, "wb") { |f| f.write(params[:dump][:file].read) }

require 'faster_csv'
 
     n=0

      	FasterCSV.foreach(path,  :col_sep => "|", :encoding => 'n') do |a|
        #a = row[0].split("|")
        c=Company.new
        c.company_name=a[0]
        c.company_state=a[1]
        c.company_city=a[2]
        c.company_address=a[3]
        c.colonia=a[4]
        c.company_postcode=a[5]
        c.company_phone=a[6]
        c.company_fax=a[7]
        c.company_site=a[8]
        c.giro=a[9]
        c.scian=a[10]
        c.employee_number=a[11]
        c.revenue=a[12]
        c.year_started=a[13]
	c.save
     	if c.save
        	n=n+1
        	GC.start if n%50==0
     	end
	flash[:notice] = "CSV Import Successful,  #{n} new records added to data base"
	end
      #  end
       # end
end

def displayCompanies
	redirect_to(:action => "index")
end

def sortByName
     @companies = Company.paginate(:page=>params[:page],:per_page=> $global_page, :conditions => ['company_name like ?', "%#{params[:search]}%"], :order => 'company_name')
     render :template => 'companies/index'
  end

  def sortByState
     @companies = Company.paginate(:page=>params[:page],:per_page=> $global_page, :conditions => ['company_name like ?', "%#{params[:search]}%"], :order => 'company_state')
     render :template => 'companies/index'
   
  end
  def sortByDateUpdated
      @companies = Company.paginate(:page=>params[:page],:per_page=> $global_page, :conditions => ['company_name like ?', "%#{params[:search]}%"], :order => 'updated_at')    
      render :template => 'companies/index'
  end
  def sortByNumber
     render :template => 'companies/index'
  end
  # GET /companies
  # GET /companies.xml
  def index
       @results = Company.find(:all, :conditions => ['company_name LIKE ?', "%#{params[:query]}%"], :limit => "20")



       @query = params[:search]
       if @query 
        	if params[:sort].nil?
			@companies = Company.paginate(:page=>params[:page],:per_page=> 20,:conditions => ['company_name like ? AND (root = ? OR company_location_id is NULL)', "%#{params[:search]}%", "t"], :order => 'company_name')
		end       
       end
       respond_to do |format|
           format.js
  	   format.html # index.html.erb
   	   format.xml  { render :xml => @companies.to_xml(:only =>[:company_name, :company_phone, :updated_at, :company_city, :company_site, :company_state]) }
       end

  end


  # GET /companies/1
  # GET /companies/1.xml
  def show
    begin
    @company = Company.find(params[:id])
    rescue ActiveRecord::RecordNotFound
    return render :xml => "<WARNING>there is not a company for that id</WARNING>"
    end
    @signature = params[:signature]
    params = request.query_parameters.reject {|key, value| key.to_s == "signature"}
    params.sort_by {|key, value| key.to_s.underscore}.join('')
    @parameters = params.to_s
    @secret = ApplicationAccount.api_secret_field
    @app_key = ApplicationAccount.api_key_field
    respond_to do |format|
      format.html # show.html.erb
        if params[:app_key] == @app_key
           if @signature == Digest::MD5.hexdigest("#{@app_key}#{@parameters}#{@secret}").to_s
                if @company
                   format.xml  { render :xml => @company.to_xml(:only => [:id, :company_name, :company_city, :company_state, :updated_at]) }
               else
                   format.xml  { render :xml => "<WARNING>there is not a company for that id</WARNING>" }
               end
		#format.xml  { render :xml => Digest::MD5.hexdigest("#{@app_key}#{@parameters}#{@secret}").to_s 
           else
               @test = Digest::MD5.hexdigest("#{@app_key}#{@parameters}#{@secret}").to_s
               format.xml  { render :xml => "<WARNING>El signature debe ser: #{@test} </WARNING>" }
           end
        end
    end
  end

  # GET /companies.xml?search=""
  def apiSearch
    @company = Company.find(:all, :conditions => ['company_name LIKE ?', "%#{params[:search]}%"], :limit => "10")
    @signature = params[:signature]
    params = request.query_parameters.reject {|key, value| key.to_s == "signature"}
    params.sort_by {|key, value| key.to_s.underscore}.join('')
    @parameters = params.to_s
    @secret = ApplicationAccount.api_secret_field
    @app_key = ApplicationAccount.api_key_field
    respond_to do |format|
        format.html # show.html.erb
        if params[:app_key] == @app_key
           if @signature == Digest::MD5.hexdigest("#{@app_key}#{@parameters}#{@secret}").to_s
               format.xml  { render :xml => @company.to_xml(:only => [:id, :company_name, :company_city, :company_state, :updated_at]) }
		#format.xml  { render :xml => Digest::MD5.hexdigest("#{@app_key}#{@parameters}#{@secret}").to_s }
           else
               @test = Digest::MD5.hexdigest("#{@app_key}#{@parameters}#{@secret}").to_s
               format.xml  { render :xml => "<WARNING>El signature debe ser: #{@test} </WARNING>" }
           end
        end
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
