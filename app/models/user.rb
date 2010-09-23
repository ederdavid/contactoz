class User < ActiveRecord::Base
  
  acts_as_authentic do |config|
    config.login_field = 'email'
    config.validate_email_field    = false
    config.validate_login_field    = false
    config.validate_password_field = false
  end
  
  include Profile
  
  has_many :actions
  has_many :contact_saveds
  has_many :contacts, :through => :contact_saveds
  has_many :topics, :through => :categorizations
  has_many :categorizations
  named_scope :with_topics, :conditions => 'id in (select distinct user_id from categorizations)'

  #validates_presence_of :screen_name
  acts_as_recommendable :contacts, :through => :contact_saveds

  def find_topics
  	@topic = Topic.find(:all, :conditions => ['id in (select distinct topic_id from categorizations where user_id = ?)', self])
  end

  def find_feeds
        @feeds = Feed.find(:all, :conditions => ['id in (select distinct feed_id from categorizations where user_id = ?)', self])
  end


  def self.find_by_login_or_email(login)
  	User.find_by_email(login)
  end

  def deliver_password_reset_instructions!
    reset_perishable_token!
    Notifier.deliver_password_reset_instructions(self)
  end
  def activate!
    self.active = true
    save
  end
  def deliver_activation_instructions!
    reset_perishable_token!
    Notifier.deliver_activation_instructions(self)
  end
  def deliver_welcome!
    reset_perishable_token!
    Notifier.deliver_welcome(self)
  end
end
