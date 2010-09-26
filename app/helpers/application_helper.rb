# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

	def controller_stylesheet_link_tag
  		stylesheet = "#{params[:controller]}.css"
    
  		if File.exists?(File.join(Rails.public_path, 'stylesheets', stylesheet))
    		   stylesheet_link_tag stylesheet
  		end
	end


  MOBILE_BROWSERS = ["android", "ipod", "opera mini", "blackberry", "palm","hiptop","avantgo","plucker", "xiino","blazer","elaine", "windows ce; ppc;", "windows ce; smartphone;","windows ce; iemobile", "up.browser","up.link","mmp","symbian","smartphone", "midp","wap","vodafone","o2","pocket","kindle", "mobile","pda","psp","treo"]

  def mobile_device?
    agent = request.headers["HTTP_USER_AGENT"].downcase
    MOBILE_BROWSERS.each do |m|
		request.format = :mobile if agent.match(m) 
    end
  end


end
