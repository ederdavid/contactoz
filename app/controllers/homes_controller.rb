class HomesController < ApplicationController
    layout 'application'
    set_tab :home

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
       @Contact = @Contact.company_name
       @data = "#{@data}\r\n#{@Contact}\r\n#{@message}\r\n"
    end
    render :text => @data
  end

  # GET /homes
  # GET /homes.xml
  def index
    @homes = Home.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @homes }
    end
   
 end

  # GET /homes/1
  # GET /homes/1.xml
  def show
    @home = Home.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @home }
    end
  end

  # GET /homes/new
  # GET /homes/new.xml
  def new
    @home = Home.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @home }
    end
  end

  # GET /homes/1/edit
  def edit
    @home = Home.find(params[:id])
  end

  # POST /homes
  # POST /homes.xml
  def create
    @home = Home.new(params[:home])

    respond_to do |format|
      if @home.save
        format.html { redirect_to(@home, :notice => 'Home was successfully created.') }
        format.xml  { render :xml => @home, :status => :created, :location => @home }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @home.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /homes/1
  # PUT /homes/1.xml
  def update
    @home = Home.find(params[:id])

    respond_to do |format|
      if @home.update_attributes(params[:home])
        format.html { redirect_to(@home, :notice => 'Home was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @home.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /homes/1
  # DELETE /homes/1.xml
  def destroy
    @home = Home.find(params[:id])
    @home.destroy

    respond_to do |format|
      format.html { redirect_to(homes_url) }
      format.xml  { head :ok }
    end
  end
end
