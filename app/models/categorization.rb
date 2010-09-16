class Categorization < ActiveRecord::Base
	belongs_to :topic
	belongs_to :feed

        #belongs_to :service
        #belongs_to :product


end
