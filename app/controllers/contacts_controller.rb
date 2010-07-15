class ContactsController < ApplicationController
    layout 'standard'
    set_tab :contact

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

  # GET /contacts
  # GET /contacts.xml
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
	if !$allContacts
    		@contacts = Contact.all
	else
		$results = Company.find($allContacts).contacts.paginate(:page=>params[:page],:per_page=> 3, :order => 'name')
		$allContacts = nil
	end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @contacts }
    end
  end

  # GET /contacts/1
  # GET /contacts/1.xml
  def show
    @contact = Contact.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @contact }
    end
  end

  # GET /contacts/new
  # GET /contacts/new.xml
  def new
    @contact = Contact.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @contact }
    end
  end

  # GET /contacts/1/edit
  def edit
    @contact = Contact.find(params[:id])
  end

  # POST /contacts
  # POST /contacts.xml
  def create
    @contact = Contact.new(params[:contact])

    if current_user
        @action = Action.new({:points => 2, :entity_changed => "contact" , :action => "create", :user_id => current_user.id })
        @action.save
        @user = User.find(current_user.id)
        @user.points= 2 + @user.points
        @user.save

    	respond_to do |format|
      		if @contact.save
        		format.html { redirect_to(@contact, :notice => 'Contact was successfully created.') }
        		format.xml  { render :xml => @contact, :status => :created, :location => @contact }
      		else
        		format.html { render :action => "new" }
        		format.xml  { render :xml => @contact.errors, :status => :unprocessable_entity }
      		end
    	end
     end
  end

  # PUT /contacts/1
  # PUT /contacts/1.xml
  def update

    if current_user
    
      @contact = Contact.find(params[:id])
      
      #update actions table
  
      @action = Action.new({:points => 2, :entity_changed => "contact" , :action => "update", :user_id => current_user.id })
      @action.save

      @user = User.find(current_user.id)
      @user.points= 2 + @user.points
      @user.save

    	respond_to do |format|
      		if @contact.update_attributes(params[:contact])
        		format.html { redirect_to(@contact, :notice => 'Contact was successfully updated.') }
        		format.xml  { head :ok }
      		else
        		format.html { render :action => "edit" }
        		format.xml  { render :xml => @contact.errors, :status => :unprocessable_entity }
      		end
    	end
    end 

  end

  # DELETE /contacts/1
  # DELETE /contacts/1.xml
  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy

    respond_to do |format|
      format.html { redirect_to(contacts_url) }
      format.xml  { head :ok }
    end
  end
end
