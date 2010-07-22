class UserObserver < ActiveRecord::Observer
 def after_create(user)
  UserMailer.deliver_welcome_email(user)
 end
 def after_invite(user)
  UserMailer.deliver_invite_email(user)
 end
end 
