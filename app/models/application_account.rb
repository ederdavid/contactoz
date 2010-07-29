class ApplicationAccount < ActiveRecord::Base
  acts_as_authentic do |config|
  end # the configuration block is optional
end

