class ProductsController < ApplicationController

  # GET /products/1
  # GET /products/1.xml
  def show
    @product = Product.find(params[:id])
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
    @buy = 0
    if params[:buy] == "1"
        @buy = 1
    else
        @buy = @buy
    end
    if params[:sell] == "1"
        @buy = 0
    else
        @buy = @buy
    end
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
               @product.buy = @buy
	       @product.save
               format.xml  { render :xml => @product.to_xml(:only => [:id, :name, :description, :contact_name, :contact_title, :contact_email, :buy, :sell, :created_at, :updated_at]) }
           end
      end
    end
  end

# GET /products.xml?search=""
  def apiSearch
    @product = Product.find(params[:id])
    @product = Product.find(:all, :conditions => ['name LIKE ?', "%#{params[:search]}%"], :limit => "20")
    if params[:buy] && params[:sell]
        @product = Product.find(:all, :id => params[:id], :buy => params[:buy], :sell => params[:sell])
    end
    if params[:buy]
        @product = Product.find(:all, :id => params[:id], :buy => params[:buy])
    end
    if params[:sell]
        @product = Product.find(:all, :id => params[:id], :sell => params[:sell])
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
               format.xml  { render :xml => @product.to_xml(:only => [:id, :name, :description, :contact_name, :contact_title, :contact_email, :buy, :sell, :created_at, :updated_at]) }
           end
      end
    end
  end

end
