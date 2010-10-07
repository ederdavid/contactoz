class ServicesController < ApplicationController
	    layout 'feed'

	require 'pusher'
        Pusher.app_id = '1749'
        Pusher.key = '92a18c1392e252d076c6'
        Pusher.secret = '2a253676fad3558f8446'

  # GET /services/1
  # GET /services/1.xml
  def show
    begin
    @service = Service.find(params[:id])
    rescue ActiveRecord::RecordNotFound
    return render :xml => "<WARNING>there is not a company for that id</WARNING>"
    end
    @signature = params[:signature]
    #@auth = false
    #if params[:email] and params[:password]
    #    @user = User.find_by_email(params[:email])
    #    if @user.password == params[:password]
    #        @auth = true
    #    else
    #        @auth = false
    #    end
    #end
    params = request.query_parameters.reject {|key, value| key.to_s == "signature"}
    params.sort_by {|key, value| key.to_s.underscore}.join('')
    @parameters = params.to_s
    @secret = ApplicationAccount.api_secret_field
    @app_key = ApplicationAccount.api_key_field
    respond_to do |format|
      format.html # show.html.erb
      if params[:app_key] == @app_key #and @auth
           if @signature == Digest::MD5.hexdigest("#{@app_key}#{@parameters}#{@secret}").to_s
               #format.xml  { render :xml => Digest::MD5.hexdigest("#{@app_key}#{@parameters}#{@secret}").to_s }
               if @service != nil
                   format.xml  { render :xml => @service.to_xml(:only => [:id, :name, :description, :contact_name, :contact_title, :contact_email, :buy, :created_at, :updated_at]) }
               else
                   format.xml  { render :xml => "<WARNING>there is not a service for that if</WARNING>" }
               end
           end
      end
    end
  end

# GET /services.xml?search=""
# GET /services.xml?search=""
  def apiSearch
    if params[:search]

	@service = Service.find(:all, :conditions => ['name LIKE ?', "%#{params[:search]}%"], :limit => "10")

       #@service = Service.find_by_name(params[:search])
    end
    if params[:buy] && params[:search]
        @service = Service.find(:all, :conditions => ['buy LIKE ? AND name LIKE ?', "#{params[:buy]}", "%#{params[:search]}%"], :limit => "20")
    end
    if params[:sell] && params[:search]
        @service = Service.find(:all, :conditions => ['sell LIKE ? AND name LIKE ?', "#{params[:sell]}", "%#{params[:search]}%" ], :limit => "20")
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
	       #format.xml  { render :xml => Digest::MD5.hexdigest("#{@app_key}#{@parameters}#{@secret}").to_s }
               if @service != nil
                   format.xml  { render :xml => @service.to_xml(:only => [:id, :name, :description, :contact_name, :contact_title, :contact_email, :buy, :sell, :created_at, :updated_at]) }
               else
                   format.xml  { render :xml => "<WARNING>there is not such a service</WARNING>" }
               end
           end
      end
    end



  end

     # POST /homes
  # POST /homes.xml
  def create

    @service = Service.new(params[:service])
    respond_to do |format|
      if @service.save

        format.html {  }
        format.xml  { render :xml => @service }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @service }
      end
    end
  end

     # POST /homes
  # POST /homes.xml
  def create_feed

    @service = Service.new(params[:service])
    respond_to do |format|
      if @service.save
       
        Pusher['post'].trigger('thing-create', @service.attributes)
        #@service.update_followers

        format.html {  }
        format.xml  { render :xml => @service }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @service }
      end
    end
  end






end
