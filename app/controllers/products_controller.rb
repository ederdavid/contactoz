class ProductsController < ApplicationController
           layout 'user'


  # GET /products/1
  # GET /products/1.xml
  def show
    begin
    @product = Product.find(params[:id])
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
               if @product
                   format.xml  { render :xml => @product.to_xml(:only => [:id, :name, :description, :contact_name, :contact_title, :contact_email, :buy, :sell, :created_at, :updated_at]) }
               else
                   format.xml  { render :xml => "<WARNING>there is not a product for that id</WARNING>" }
               end
           end
      end
    end
  end

# GET /products.xml?search=""
  def apiSearch
    if (params[:search])
       @product = Product.find(params[:search])
    end
    if params[:buy] && params[:sell]
        @product = Product.find(:all, :conditions => ['buy LIKE ? AND sell LIKE ?', "#{params[:buy]}", "#{params[:sell]}"], :limit => "20")
    end
    if params[:buy]
        @product = Product.find(:all, :conditions => ['buy LIKE ?', "#{params[:buy]}"], :limit => "20")
    end
    if params[:sell]
        @product = Product.find(:all, :conditions => ['sell LIKE ?', "#{params[:sell]}"], :limit => "20")
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
               if @product == nil
                   format.xml  { render :xml => @product.to_xml(:only => [:id, :name, :description, :contact_name, :contact_title, :contact_email, :buy, :sell, :created_at, :updated_at]) }
               else
                   format.xml  { render :xml => "<WARNING>there is not such a product</WARNING>" }
               end
           end
      end
    end
  end

end
