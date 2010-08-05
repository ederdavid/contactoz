class ApplicationAccount < ActiveRecord::Base
  acts_as_authentic do |config|
      #config.api_key_field :app_key
      #config.api_secret :api_secret
  end # the configuration block is optional
end

