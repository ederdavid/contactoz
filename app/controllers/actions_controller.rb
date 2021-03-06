class ActionsController < ApplicationController
    
	layout 'secondary'

  # GET /actions
  # GET /actions.xml
  def index
    @actions = Action.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @actions }
    end
  end

  # GET /actions/1
  # GET /actions/1.xml
  def show
    @action = Action.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @action }
    end
  end

  # GET /actions/new
  # GET /actions/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /actions/1/edit
  def enter 
   
   # @action = Action.find(params[:id])
  end

  # POST /actions
  # POST /actions.xml
  def create
    @action = Action.new(params[:action])

    respond_to do |format|
      if @action.save
        format.html { redirect_to(@action, :notice => 'Action was successfully created.') }
        format.xml  { render :xml => @action, :status => :created, :location => @action }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @action.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /actions/1
  # PUT /actions/1.xml
  def update
    @action = Action.find(params[:id])

    respond_to do |format|
      if @action.update_attributes(params[:action])
        format.html { redirect_to(@action, :notice => 'Action was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @action.errors, :status => :unprocessable_entity }
      end
    end
  end

end
