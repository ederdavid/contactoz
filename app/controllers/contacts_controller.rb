class ContactsController < ApplicationController
    layout 'standard'
    set_tab :contact

  # GET /contacts
  # GET /contacts.xml
  def index

    if params[:search]

        @contacts = Contact.paginate(:page=>params[:page],:per_page=> 3,:conditions => ['name like ?', "%#{params[:search]}%"], :order => 'name')
#       @contacts = Contact.search(params[:search],params[:page])
    else
        @contacts = nil
    end

    @contacts = Contact.all

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
