class Topic < ActiveRecord::Base
 	belongs_to :feed
        belongs_to :company
        belongs_to :news

 def find_users_following
        @users_following = User.with_topics.find(:all, :conditions => ['id in (select distinct user_id from categorizations where topic_id = ?)', self])
  end

end
