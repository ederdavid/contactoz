class UserObserver < ActiveRecord::Observer
 def after_create(user)
  UserMailer.deliver_welcome_email(user)
  mail = UserMailer.create_welcome_email(user)
  UserMailer.deliver(mail)
  end
end 
