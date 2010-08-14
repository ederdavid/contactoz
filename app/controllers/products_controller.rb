class ProductsController < ApplicationController

  # GET /products/1
  # GET /products/1.xml
  def show
    @product = Product.find(params[:id])
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
               format.xml  { render :xml => @product.to_xml(:only => [:id, :created_at, :updated_at]) }
           end
      end
    end
  end

end