class PostsController < ApplicationController
        layout 'application'
	require 'pusher'

	Pusher.app_id = '1749'
	Pusher.key = '92a18c1392e252d076c6'
	Pusher.secret = '2a253676fad3558f8446'

  # GET /posts
  # GET /posts.xml
  def index
    @posts = Post.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end

  

  # GET /posts/1
  # GET /posts/1.xml
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.xml

    def create
	Pusher['post'].trigger('thing-create', 'success')

        @name = params[:name]
	@description = params[:description]
        @contact_name = params[:contact_name]
        @contact_phone = params[:contact_phone]
	@contact_email = params[:contact_email]
        @contact_title = params[:contact_title]
        @type =params[:type]

	#if @type.equals("service")

        @service = Service.new(:name => @name, :description => @description, :contact_name => @contact_name, :contact_phone => @contact_phone, :contact_email => @contact_email, :contact_title => @contact_title)
		if @service.save
			Pusher['things'].trigger('thing-create', @service.attributes)
		end
	#else
	#@product = Product.new(:name => @name, :description => @description, :contact_name => @contact_name, :contact_phone => @contact_phone, :contact_email => @contact_email, :contact_title => @contact_title)
	#	if @product.save
	#		Pusher['things'].trigger('thing-create', @product.attributes)
	#	end
	#end

    end


  # PUT /posts/1
  # PUT /posts/1.xml
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to(@post, :notice => 'Post was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(posts_url) }
      format.xml  { head :ok }
    end
  end
end