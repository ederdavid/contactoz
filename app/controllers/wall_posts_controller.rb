class WallPostsController < ApplicationController
  def create
    if params[:social_type] == 'twitter'
      access_token = session[:current_user].get_token(:twitter)
      consumer = AuthlogicConnect.consumer(:twitter)
      client = TwitterOAuth::Client.new(
        :consumer_key => consumer.key,
        :consumer_secret => consumer.secret,
        :token => access_token.token, 
        :secret => access_token.secret
      )
      result = client.update(params[:msg])
      logger.debug(result.inspect)
      
    end
  end
end