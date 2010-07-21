class UserMailer < ActionMailer::Base
 def welcome_email(user)
  recipients user.email
  from "El directorio de companias <no-reply@contacto.com>"
  subject "Bienvenido al directorio de companias"
  sent_on Time.now
 body :user => user, @url = "http://contacto.heroku.com/"
 end
end 
