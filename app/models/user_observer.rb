class UserObserver < ActiveRecord::Observer
  def after_create(user)
    #If user signs up with twitter/facebook/linked_in
    #skip sending email
    if user.authenticated_with.empty?
      UserMailer.deliver_welcome_email(user)
    end

  end
  def after_invite(user)
    UserMailer.deliver_invite_email(user)
  end
end 
