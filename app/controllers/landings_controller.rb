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




end
