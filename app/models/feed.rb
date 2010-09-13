class Feed < ActiveRecord::Base
	named_scope :by_date, :order => "created_at DESC"
        named_scope :most_recent, :order => "created_at DESC LIMIT 20"
        named_scope :most_recent_buy, :order => "created_at DESC LIMIT 20", :conditions => {:buy => '1'}
        named_scope :most_recent_sell, :order => "created_at DESC LIMIT 20", :conditions => {:sell => '1'}
       	has_many :topics, :through => :categorizations
        has_many :categorizations

end

