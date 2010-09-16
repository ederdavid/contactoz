class CompanyCategorization < ActiveRecord::Base
       belongs_to :topic
       belongs_to :company
end
