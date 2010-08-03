class DisplayCompaniesController < ApplicationController
	layout 'display_companies'

  # GET /display_companies
  # GET /display_companies.xml
  def index
    @display_companies = DisplayCompany.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @display_companies }
    end
  end

  # GET /display_companies/1
  # GET /display_companies/1.xml
  def show
      @company_selected = Company.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @display_company }
    end
  end

  # GET /display_companies/new
  # GET /display_companies/new.xml
  def new
    @display_company = DisplayCompany.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @display_company }
    end
  end

  # GET /display_companies/1/edit
  def edit
    @display_company = DisplayCompany.find(params[:id])
  end

  # POST /display_companies
  # POST /display_companies.xml
  def create
    @display_company = DisplayCompany.new(params[:display_company])

    respond_to do |format|
      if @display_company.save
        format.html { redirect_to(@display_company, :notice => 'DisplayCompany was successfully created.') }
        format.xml  { render :xml => @display_company, :status => :created, :location => @display_company }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @display_company.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /display_companies/1
  # PUT /display_companies/1.xml
  def update
    @display_company = DisplayCompany.find(params[:id])

    respond_to do |format|
      if @display_company.update_attributes(params[:display_company])
        format.html { redirect_to(@display_company, :notice => 'DisplayCompany was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @display_company.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /display_companies/1
  # DELETE /display_companies/1.xml
  def destroy
    @display_company = DisplayCompany.find(params[:id])
    @display_company.destroy

    respond_to do |format|
      format.html { redirect_to(display_companies_url) }
      format.xml  { head :ok }
    end
  end
end
