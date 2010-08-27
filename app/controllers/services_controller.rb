class ServicesController < ApplicationController

  # GET /services/1
  # GET /services/1.xml
  def show
    @service = Service.find(params[:id])
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
               format.xml  { render :xml => @service.to_xml(:only => [:id, :name, :description, :contact_name, :contact_title, :contact_email, :buy, :created_at, :updated_at]) }
           end
      end
    end
  end

        @thing = Post.new(params[:post])
        Pusher['post'].trigger('thing-create', 'success')
        if @thing.save
                Pusher['things'].trigger('thing-create', @thing.attributes)
        end


    def create
        @thing = Service.new(params[:service])
        Pusher['post'].trigger('thing-create', 'success')
        if @thing.save
                Pusher['things'].trigger('thing-create', @thing.attributes)
        end
    end



end
