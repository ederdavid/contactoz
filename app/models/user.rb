class User < ActiveRecord::Base
  has_many :actions
  validates_presence_of :screen_name

  acts_as_authentic do |c|
     c.login_field = 'email'
  end

  def self.find_by_login_or_email(login)
  	User.find_by_email(login)
  end

end
