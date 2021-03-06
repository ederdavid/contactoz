class ContactSavedsController < ApplicationController

  def comprar
     @ids = params[:contactSaveds]
     for contact_saveds in @ids
        @contact_saveds=ContactSaved.find_or_create_by_id(contact_saveds[1])
        @contact_saveds.update_attributes(:purchased => '1')
	@contact_saveds.save
     end
     redirect_to( :controller => 'users', :action => current_user.id, :notice => 'Contacts was successfully purchased!')
  end  

  def borrar
     @ids  = params[:contact_saveds]
     for contact_saveds in @ids
        @contact_saveds = ContactSaved.find(contact_saveds)
        @contact_saveds.destroy
     end 
     redirect_to( :controller => 'users', :action => current_user.id)
  end

  # GET /contact_saveds
  # GET /contact_saveds.xml
  def index
    @contact_saveds = ContactSaved.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @contact_saveds }
    end
  end

  # GET /contact_saveds/1
  # GET /contact_saveds/1.xml
  def show
    @contact_saved = ContactSaved.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @contact_saved }
    end
  end

  # GET /contact_saveds/new
  # GET /contact_saveds/new.xml
  def new
    @contact_saved = ContactSaved.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @contact_saved }
    end
  end

  # GET /contact_saveds/1/edit
  def edit
    @contact_saved = ContactSaved.find(params[:id])
  end

  # POST /contact_saveds
  # POST /contact_saveds.xml
  def create
    @contact_saved = ContactSaved.new(params[:contact_saved])

    respond_to do |format|
      if @contact_saved.save
        format.html { redirect_to(@contact_saved, :notice => 'ContactSaved was successfully created.') }
        format.xml  { render :xml => @contact_saved, :status => :created, :location => @contact_saved }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @contact_saved.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /contact_saveds/1
  # PUT /contact_saveds/1.xml
  def update
    @contact_saved = ContactSaved.find(params[:id])

    respond_to do |format|
      if @contact_saved.update_attributes(params[:contact_saved])
        format.html { redirect_to(@contact_saved, :notice => 'ContactSaved was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @contact_saved.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /contact_saveds/1
  # DELETE /contact_saveds/1.xml
  def destroy
    @contact_saved = ContactSaved.find(params[:id])
    @contact_saved.destroy

    respond_to do |format|
      format.html { redirect_to(contact_saveds_url) }
      format.xml  { head :ok }
    end
  end
end
