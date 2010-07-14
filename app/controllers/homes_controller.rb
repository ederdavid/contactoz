class HomesController < ApplicationController
    layout 'standard'
    set_tab :home

  def sortByName
     $name = "1"
	$city = nil
	$country = nil
	$linked = nil
	$title = nil
	$lupdated = nil
     redirect_to(:action => "index")
  end
  def sortByTitle
     $title = "1"
	$name = nil
	$city = nil
	$country = nil
	$linked = nil
	$lupdated = nil
     redirect_to(:action => "index")
  end
  def sortByCity
     $city = "1"
	$name = nil
	$country = nil
	$linked = nil
	$title = nil
	$lupdated = nil
     redirect_to(:action => "index")
  end
  def sortByCountry
     $country = "1"
	$name = nil
	$city = nil
	$linked = nil
	$title = nil
	$lupdated = nil
     redirect_to(:action => "index")
  end
  def sortByLinkedInId
     $linked = "1"
	$name = nil
	$city = nil
	$country = nil
	$title = nil
	$lupdated = nil
     redirect_to(:action => "index")
  end
  def sortByContactLastUpdated
     $lupdated = "1"
	$name = nil
	$city = nil
	$country = nil
	$linked = nil
	$title = nil
     redirect_to(:action => "index")
  end
  def cart
	@ids  = params[:contact]
         for contact in @ids
	        @contact=Contact.find(contact)
		@contact_saved = ContactSaved.new(:title => @contact.title, :name => @contact.name, :city => @contact.city, :state => @contact.state, :country => @contact.country, :linkedin_id => @contact.linkedin_id, :contact_last_updated => @contact.contact_last_updated, :created_at => @contact.created_at, :updated_at => @contact.updated_at, :purchased => 0)
		@contact_saved.save
	 end
        redirect_to( :controller => 'users', :action => current_user.id)
  end
  
  # GET /homes
  # GET /homes.xml
  def index
	if params[:search]
	$results = Contact.paginate(:page=>params[:page],:per_page=> 3,:conditions => ['name like ?', "%#{params[:search]}%"], :order => 'name')
	$parametro = "%#{params[:search]}%"
	else
	   $results = nil
	end
	if $name
	$results = Contact.paginate(:page=>params[:page],:per_page=> 3,:conditions => ['name like ?', $parametro], :order => 'name')
	end
	if $title
	$results = Contact.paginate(:page=>params[:page],:per_page=> 3,:conditions => ['name like ?', $parametro], :order => 'title')
	end
	if $city
	$results = Contact.paginate(:page=>params[:page],:per_page=> 3,:conditions => ['name like ?', $parametro], :order => 'city')
	end
        if $country
	$results = Contact.paginate(:page=>params[:page],:per_page=> 3,:conditions => ['name like ?', $parametro], :order => 'country')
	end
        if $linked
	$results = Contact.paginate(:page=>params[:page],:per_page=> 3,:conditions => ['name like ?', $parametro], :order => 'linkedin_id')
	end
        if $lupdated
	$results = Contact.paginate(:page=>params[:page],:per_page=> 3,:conditions => ['name like ?', $parametro], :order => 'contact_last_updated')
	end
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
