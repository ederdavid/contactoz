class UsersController < ApplicationController
	layout 'user'

skip_before_filter :verify_authenticity_token

    # GET /posts/1
  # GET /posts/1.xml
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users
  # GET /users.xml
  def index
    @users = User.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def infoUser

    @user_session = UserSession.new(params[:user_session])
    @email = params[:user_session][:email]

    if @user_session.save
        @user = User.find(:all, :conditions => ['email = ?', @email], :limit => "1")
        @user_session.destroy
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
               if @user
                   format.xml  { render :xml => @user.to_xml(:only => [:id, :profession, :screen_name, :first_name, :last_name, :email, :level, :points]) }
               else
                   format.xml  { render :xml => "<WARNING>there is not a user for that id</WARNING>" }
               end
           end
        end
    end

 end

  # GET /users/1
  # GET /users/1.xml
  def show
    begin
    @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
    return render :xml => "<WARNING>there is not a user for that id</WARNING>"
    end
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
               if @user
                   format.xml  { render :xml => @user.to_xml(:only => [:id, ':profession', :screen_name, ':first_name', ':last_name', ':email', ':level', ':points']) }
               else
                   format.xml  { render :xml => "<WARNING>there is not a user for that id</WARNING>" }
               end
           end
        end
    end
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
               format.xml  { render :xml => @user.to_xml(:only => [:id, ':profession', ':first_name', ':last_name', ':email', ':level', ':points']) }
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

  def follow
  
    @user = params[:user_id]
    @topic = params[:topic_id]
    @feed = params[:feed_id]


    if @feed
    	Categorization.create(:user_id=>@user,:feed_id=> @feed)
    end

    if @topic
        Categorization.create(:user_id=>@user,:topic_id=> @topic)
    end

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

        @feed = Feed.new(:name => @name, :description => @description, :contact_name => @contact_name, :contact_phone => @contact_phone, :contact_email => @contact_email, :contact_title => @contact_title)
                if @feed.save
                                Pusher['post'].trigger('thing-create', "string_passed")
                end
     end

  # GET /users/1/edit
  def edit
    @user = current_user
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

      #deactivate points 
      #@action = Action.new({:points => 2, :entity_changed => "user" , :action => "invite", :user_id => current_user.id })
      #@action.save
      #@user = User.find(current_user.id)
      #current_user.points= 5 + @user.points
      #current_user.save


      if params[:email_0]
	      UserMailer.deliver_invite_email(params[:email_0])
      end
      if params[:email_1]
              UserMailer.deliver_invite_email(params[:email_1])
      end
      if params[:email_2]
              UserMailer.deliver_invite_email(params[:email_2])
      end
      if params[:email_3]
              UserMailer.deliver_invite_email(params[:email_3])
      end
      if params[:email_4]
              UserMailer.deliver_invite_email(params[:email_4])
      end
      if params[:email_5]
              UserMailer.deliver_invite_email(params[:email_5])
      end

      redirect_to root_url
  end
  # POST /users
  # POST /users.xml
  def create
    @user = User.new(
      :firstname=> params[:firstname], 
      :lastname=> params[:lastname], 
      :email => params[:email], 
      :password => params[:password]
    )
    @user.points = 0
    
    @user.save do |result|
      if result
        
        flash[:notice] = "Your account has been created. Please check your e-mail for your account activation instructions!"
        
        #If user signs up with twitter/facebook/linked_in
        #skip sending email and go to 'users/:id' page
        if @user.authenticated_with.empty?
          @user.deliver_activation_instructions!	
          redirect_to actions_url and return
        else
          redirect_to user_path(@user) and return
        end

        redirect_to actions_url and return
      else
        redirect_to actions_url and return
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = current_user

      if @user.update_attributes(params[:user])
         flash[:notice] = "Successfully updated profile."  
         redirect_to root_url  
      else
	render :action => 'edit'
      end
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
