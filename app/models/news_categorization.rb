class NewsCategorization < ActiveRecord::Base
       belongs_to :topic
       belongs_to :news
end
