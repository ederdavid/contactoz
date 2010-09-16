class AdvertCategorization < ActiveRecord::Base
        belongs_to :advertisement
        belongs_to :topic
end
