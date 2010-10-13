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
   
   @prospect = Prospect.create(:email => params[:email])
   if @prospect.save
      flash[:notice] = "... recibirá un mensaje antes de su lanzamiento"
   end

       render :action => 'index'
  end



end
