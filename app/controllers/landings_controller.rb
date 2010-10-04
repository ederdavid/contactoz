class LandingsController < ApplicationController
   layout 'landings'

  # GET /landings
  # GET /landings.xml
  def index
    @landings = Landing.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @landings }
    end
  end



  # POST /landings
  # POST /landings.xml
  def create
    @landing = Landing.new(params[:landing])

    respond_to do |format|
      if @landing.save
        format.html { redirect_to(@landing, :notice => 'Landing was successfully created.') }
        format.xml  { render :xml => @landing, :status => :created, :location => @landing }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @landing.errors, :status => :unprocessable_entity }
      end
    end
  end

end
