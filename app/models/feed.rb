class Feed < ActiveRecord::Base
	named_scope :by_date, :order => "created_at DESC"
        named_scope :most_recent, :order => "created_at DESC LIMIT 20"
       	has_many :topics, :through => :categorizations
        has_many :categorizations

end

