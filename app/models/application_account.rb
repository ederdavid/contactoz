class ApplicationAccount < ActiveRecord::Base
  acts_as_authentic do |config|
      config.api_key_field = 'B7H98crZ'
      config.api_secret_field = 'C8I09dsA'
  end # the configuration block is optional
end

