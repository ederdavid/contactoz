class Topic < ActiveRecord::Base
 	belongs_to :service
	belongs_to :product
end
