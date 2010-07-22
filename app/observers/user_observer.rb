class UserObserver < ActiveRecord::Observer
 def after_create(user)
  UserMailer.welcome_email(user).deliver
 end
 def after_invite(user)
  UserMailer.invite_email(user).deliver
 end
end 
