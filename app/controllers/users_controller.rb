class UsersController < ApplicationController
	layout 'user'

  # GET /users
  # GET /users.xml
  def index
    @users = User.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  def infoUser
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
    #code for returning user account information in xml --> tu codigo esta aqui
    @user = current_user
    format.xml { render :xml => @user }
    #then destroy session
    @user_session.destroy

    else
        #code for returning error message (pswrd and username are not correct) in xml
        format.xml { render :xml => "There is a problem with the username or password" }
     end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])
    @contact_saveds = ContactSaved.all
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
	       #format.xml  { render :xml => Digest::MD5.hexdigest("#{@app_key}#{@parameters}#{@secret}").to_s }
               format.xml  { render :xml => @user.to_xml(:only => [:id, ':profession', :screen_name, ':first_name', ':last_name', ':email', ':level', ':points']) }
           end
        end
    end
    #respond_to do |format|
#	response.headers['Content-type'] = 'text/javascript; charset=utf-8'
 #     format.html # show.html.erb
  #    format.xml  { render :xml => @contact_saveds }
   # end
  end

  # GET /users.xml?search=""
  def apiSearch
    @user = User.find(:all, :conditions => ['first_name LIKE ?', "%#{params[:search]}%"], :limit => "10")
    @signature = params[:signature]
    params = request.query_parameters.reject {|key, value| key.to_s == "signature"}
    params.sort_by {|key, value| key.to_s.underscore}.join('')
    @parameters = params.to_s
    @secret = ApplicationAccount.api_secret_field
    @app_key = ApplicationAccount.api_key_field
    respond_to do |format|
        format.html # show.html.erb
        if params[:app_key] == @app_key
           if @signature == Digest::MD5.hexdigest("#{@parameters}#{@secret}").to_s
               format.xml  { render :xml => @user.to_xml(:only => [:id, ':profession', :screen_name, ':first_name', ':last_name', ':email', ':level', ':points']) }
		#format.xml  { render :xml => Digest::MD5.hexdigest("#{@parameters}#{@secret}").to_s }
           end
        end
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

    def add_post
	
	require 'pusher'

        Pusher.app_id = '1749'
        Pusher.key = '92a18c1392e252d076c6'
        Pusher.secret = '2a253676fad3558f8446'

        @name = params[:name]
        @description = params[:description]
        @contact_name = params[:contact_name]
        @contact_phone = params[:contact_phone]
        @contact_email = params[:contact_email]
        @contact_title = params[:contact_title]
        @type =params[:type]

        #if @type.equals("service")

        @service = Service.new(:name => @name, :description => @description, :contact_name => @contact_name, :contact_phone => @contact_phone, :contact_email => @contact_email, :contact_title => @contact_title)
                if @service.save
                                Pusher['post'].trigger('thing-create', "string_passed")
				#Pusher['post'].trigger('thing-create', @service.attributes)

                end
        #else
        #@product = Product.new(:name => @name, :description => @description, :contact_name => @contact_name, :contact_phone => @contact_phone, :contact_email => @contact_email, :contact_title => @contact_title)
        #       if @product.save
        #               Pusher['things'].trigger('thing-create', @product.attributes)
        #       end
        #end
     end

  # GET /users/1/edit
  def edit
    @user = current_user
#User.find(params[:id])
  end

   def buy
        @user = User.find(current_user.id)
           
	if current_user
	@contact_bought=Contact.find(params[:id])
 	@contactsaved = ContactSaved.create(:title => @contact_bought.title, :city=> @contact_bought.city, :name=> @contact_bought.name, :state => @contact_bought.state, :country=> @contact_bought.country, :purchased => "1", :user_id => current_user.id) 
	redirect_to :action => 'show', :id => current_user.id
	end
  end

  def invite
      @action = Action.new({:points => 2, :entity_changed => "user" , :action => "invite", :user_id => current_user.id })
      @action.save
      @user = User.find(current_user.id)
      current_user.points= 5 + @user.points
      current_user.save
      UserMailer.deliver_invite_email(params[:email])
      redirect_to root_url
  end
  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])
    @user.points = 0
#    respond_to do |format|
    if @user.save_without_session_maintenance
      @user.deliver_activation_instructions!
      flash[:notice] = "Your account has been created. Please check your e-mail for your account activation instructions!"
      redirect_to root_url
    else
      if @user.save
       flash[:notice]= "Registration successful."
       redirect_to root_url
  
      #format.html { redirect_to(@home, :notice => 'User was successfully created.') }
      #format.xml  { render :xml => @home, :status => :created, :location => @user }

      else
         render :action => 'new'

#        format.html { render :action => "new" }
#        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }

      #end
    end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = current_user

#User.find(params[:id])

#    respond_to do |format|
      if @user.update_attributes(params[:user])
         flash[:notice] = "Successfully updated profile."  
         redirect_to root_url  

	#format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        #format.xml  { head :ok }
      else
	render :action => 'edit'
        #format.html { render :action => "edit" }
        #format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    #end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
end
