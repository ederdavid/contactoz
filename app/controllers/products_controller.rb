class ProductsController < ApplicationController
           layout 'feed'

  # POST /homes
  # POST /homes.xml
  def create
    @product = Product.new(params[:product])

    respond_to do |format|
      if @product.save
        format.html {  }
        format.xml  { render :xml => @product }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @product }
      end
    end
  end

     # POST /homes
  # POST /homes.xml
  def create_feed

    @product = Product.new(params[:service])
    respond_to do |format|
      if @service.save

        Pusher['post'].trigger('thing-create', @product.attributes)
         #Pusher['things'].trigger('thing-create', @thing.attributes)

        format.html {  }
        format.xml  { render :xml => @product }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @product }
      end
    end
  end






  # GET /products/1
  # GET /products/1.xml
  def show
    begin
    @product = Product.find(params[:id])
    rescue ActiveRecord::RecordNotFound
    return render :xml => "<WARNING>there is not a product for that id</WARNING>"
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
               if @product != nil
                   format.xml  { render :xml => @product.to_xml(:only => [:id, :name, :description, :contact_name, :contact_title, :contact_email, :buy, :sell, :created_at ]) }
               else
                   format.xml  { render :xml => "<WARNING>there is not a product for that id</WARNING>" }
               end
           else
               @test = Digest::MD5.hexdigest("#{@app_key}#{@parameters}#{@secret}").to_s
               format.xml  { render :xml => "<WARNING>El signature debe ser: #{@test} </WARNING>" }
           end
      end
    end
  end

# GET /services.xml?search=""
# GET /services.xml?search=""
  def apiSearch
    if params[:search]

        @service = Product.find(:all, :conditions => ['name LIKE ?', "%#{params[:search]}%"], :limit => "10")
    end
    if params[:buy] && params[:search]
        @service = Product.find(:all, :conditions => ['buy LIKE ? AND name LIKE ?', "#{params[:buy]}", "%#{params[:search]}%"], :limit => "20")
    end
    if params[:sell] && params[:search]
        @service = Product.find(:all, :conditions => ['sell LIKE ? AND name LIKE ?', "#{params[:sell]}", "%#{params[:search]}%" ], :limit => "20")
    end

    @signature = params[:signature]
    params = request.query_parameters.reject {|key, value| key.to_s == "signature"}
    params.sort_by {|key, value| key.to_s.underscore}.join('')
    @parameters = params.to_s
    @secret = ApplicationAccount.api_secret_field    @app_key = ApplicationAccount.api_key_field
    respond_to do |format|
      format.html # show.html.erb
      if params[:app_key] == @app_key
           if @signature == Digest::MD5.hexdigest("#{@app_key}#{@parameters}#{@secret}").to_s
               #format.xml  { render :xml => Digest::MD5.hexdigest("#{@app_key}#{@parameters}#{@secret}").to_s }
               if @service != nil
                   format.xml  { render :xml => @service.to_xml(:only => [:id, :name, :description, :contact_name, :contact_title, :contact_email, :buy, :sell, :created_at]) }
               else
                   format.xml  { render :xml => "<WARNING>there is not such a service</WARNING>" }
               end
           else
               @test = Digest::MD5.hexdigest("#{@app_key}#{@parameters}#{@secret}").to_s
               format.xml  { render :xml => "<WARNING>El signature debe ser: #{@test} </WARNING>" }
           end
      end
    end
  end






end
