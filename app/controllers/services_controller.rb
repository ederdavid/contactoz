class ServicesController < ApplicationController

  # GET /services/1
  # GET /services/1.xml
  def show
    @service = Service.find(params[:id])
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
               format.xml  { render :xml => Digest::MD5.hexdigest("#{@app_key}#{@parameters}#{@secret}").to_s }
               if @service
                   format.xml  { render :xml => @service.to_xml(:only => [:id, :name, :description, :contact_name, :contact_title, :contact_email, :buy, :created_at, :updated_at]) }
               else
                   format.xml  { render :xml => "there is not a service with that id" }
               end
           end
      end
    end
  end

# GET /services.xml?search=""
  def apiSearch
    @service = Service.find(:all, :conditions => ['name LIKE ?', "%#{params[:search]}%"], :limit => "20")
    if params[:buy] && params[:sell]
        @service = Service.find(:all, :id => params[:id], :buy => params[:buy], :sell => params[:sell])
    end
    if params[:buy]
        @service = Service.find(:all, :id => params[:id], :buy => params[:buy])
    end
    if params[:sell]
        @service = Service.find(:all, :id => params[:id], :sell => params[:sell])
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
               if @service
                   format.xml  { render :xml => @service.to_xml(:only => [:id, :name, :description, :contact_name, :contact_title, :contact_email, :buy, :created_at, :updated_at]) }
               else
                   format.xml  { render :xml => "there is not a service with that id" }
               end
           end
      end
    end
  end

end
