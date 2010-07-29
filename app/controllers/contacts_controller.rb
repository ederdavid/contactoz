class ContactsController < ApplicationController
    layout 'application'
    set_tab :contact

   

def export_to_csv
  if params[:all]
	@contacts = Contact.find(:all)
  else
	  @contacts = Array.new
	  for contact in params[:contact]
	      if !contact[1]
		@contacts << Contact.find(contact)
	      else
		@contacts << Contact.find(contact[1])
	      end
	  end

  end
  csv_string = FasterCSV.generate do |csv|
    # header row
    csv << ["id", "title", "name", "city", "state", "country", "linkedin_id", "contact_last_updated", "created_at", "updated_at", "accuracy", "company_id"]

    # data rows
    @contacts.each do |contact|
      csv << [contact.id, contact.title, contact.name, contact.city, contact.state, contact.country, contact.linkedin_id, contact.contact_last_updated, contact.created_at, contact.updated_at, contact.accuracy, contact.company_id]
    end
  end

  # send it to the browsah
  send_data csv_string,
            :type => 'text/csv; charset=iso-8859-1; header=present',
            :disposition => "attachment; filename=contacts.csv"
end

  def displayContacts
        redirect_to(:action => "index")
  end

  def sortByTitle
     @contacts = Contact.paginate(:page=>params[:page],:per_page=> $global_page, :conditions => ['title like ?', "%#{params[:search]}%"], :order => 'title')
     render :template => 'contacts/index'
  end

  def sortByCompany
      @contacts = Contact.paginate(:page=>params[:page],:per_page=> $global_page, :conditions => ['company_id like ?', "%#{params[:search]}%"], :order => 'company_id')
      render :template => 'contacts/index'
  end

  def sortByName
      @contacts = Contact.paginate(:page=>params[:page],:per_page=> $global_page, :conditions => ['name like ?', "%#{params[:search]}%"], :order => 'name')
      render :template => 'contacts/index'
  end

  def sortByDateUpdated
      @contacts = Contact.paginate(:page=>params[:page],:per_page=> $global_page, :conditions => ['updated_at like ?', "%#{params[:search]}%"], :order => 'updated_at')
      render :template => 'contacts/index'
  end

  def sortByState
      @contacts = Contact.paginate(:page=>params[:page],:per_page=> $global_page, :conditions => ['state like ?', "%#{params[:search]}%"], :order => 'state')
      render :template => 'contacts/index'
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
       @query = params[:search]
       if @query
                if params[:sort].nil?
                        @contacts = Contact.paginate(:page=>params[:page],:per_page=> 20,:conditions => ['name like ?', "%#{params[:search]}%"], :order => 'name')
                end
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
      format.xml  { render :xml => @contact.to_xml(:only => [:name, :title, :city, :department, :hierarchy]) }
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
