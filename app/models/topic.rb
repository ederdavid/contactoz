class Topic < ActiveRecord::Base
 	belongs_to :feed
        belongs_to :company
        belongs_to :news

 def find_users_following
        @users_following = User.with_topics.find(:all, :conditions => ['id in (select distinct user_id from categorizations where topic_id = ?)', self])
  end


   def self.update_specific
       @topics = Topic.find(:all, :conditions => ["specific LIKE ?", "%1%"])
       @topics.each do |p|
       		p.specific_bool= 1
		p.save
       end
  end

end
