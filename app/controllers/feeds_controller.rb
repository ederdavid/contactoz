class FeedsController < ApplicationController
        layout 'feed'
	require 'pusher'

	Pusher.app_id = '1749'
	Pusher.key = '92a18c1392e252d076c6'
	Pusher.secret = '2a253676fad3558f8446'

  # GET /posts
  # GET /posts.xml
  def index
    @posts = Feed.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end

  

  # GET /posts/1
  # GET /posts/1.xml
  def show
    @post = Feed.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    @post = Feed.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end




end
