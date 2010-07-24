class UsersController < ApplicationController
	layout 'secondary'
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
  def show
    @user = User.find(params[:id])
    @contact_saveds = ContactSaved.all

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @contact_saveds }
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

  # GET /users/1/edit
  def edit
    @user = current_user
#User.find(params[:id])
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
