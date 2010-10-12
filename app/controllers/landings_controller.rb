class LandingsController < ApplicationController
 
  layout 'landings'
#change later 
  # GET /landings
  # GET /landings.xml
  def index
    @landings = Landing.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @landings }
    end
  end


 def new_email
   
   Prospect.create(:email => params[:email])
       render :action => 'index'
   

  end



end
