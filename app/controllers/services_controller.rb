class ServicesController < ApplicationController

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
               format.xml  { render :xml => Digest::MD5.hexdigest("#{@app_key}#{@parameters}#{@secret}").to_s }
               if @service
                   format.xml  { render :xml => @service.to_xml(:only => [:id, :name, :description, :contact_name, :contact_title, :contact_email, :buy, :created_at, :updated_at]) }
               else
                   format.xml  { render :xml => "<WARNING>there is not a product for that if</WARNING>" }
               end
           end
      end
    end
  end

# GET /services.xml?search=""
# GET /products.xml?search=""
  def apiSearch
    if (params[:search])
       @service = Product.find(params[:search])
    end
    if params[:buy] && params[:sell]
        @service = Product.find(:all, :conditions => ['buy LIKE ? AND sell LIKE ?', "#{params[:buy]}", "#{params[:sell]}"], :limit => "20")
    end
    if params[:buy]
        @service = Product.find(:all, :conditions => ['buy LIKE ?', "#{params[:buy]}"], :limit => "20")
    end
    if params[:sell]
        @service = Product.find(:all, :conditions => ['sell LIKE ?', "#{params[:sell]}"], :limit => "20")
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
               if @service == nil
                   format.xml  { render :xml => @service.to_xml(:only => [:id, :name, :description, :contact_name, :contact_title, :contact_email, :buy, :sell, :created_at, :updated_at]) }
               else
                   format.xml  { render :xml => "<WARNING>there is not such a product</WARNING>" }
               end
           end
      end
    end
  end

    def create
        @thing = Service.new(params[:service])
        Pusher['post'].trigger('thing-create', 'success')
        if @thing.save
                Pusher['things'].trigger('thing-create', @thing.attributes)
        end
    end
end
