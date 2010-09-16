class Feed < ActiveRecord::Base
	named_scope :by_date, :order => "created_at DESC"
        named_scope :most_recent, :order => "created_at DESC LIMIT 20"
        named_scope :most_recent_buy, :order => "created_at DESC LIMIT 20", :conditions => {:buy => '1'}
        named_scope :most_recent_sell, :order => "created_at DESC LIMIT 20", :conditions => {:sell => '1'}
       	has_many :topics, :through => :categorizations
        has_many :categorizations

    def update_users
            
        @topics = Topic.find(:all, :conditions => ['id in (select distinct topic_id from categorizations where feed_id = ?)', self])

		for topic in @topics

			@users = topic.find_users_following
			for user in @users
				UserMailer.feed_email(@user.email, this)
			end
		end

    end
    handle_asynchronously :update_users  
    
end

