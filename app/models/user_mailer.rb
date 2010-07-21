class UserMailer < ActionMailer::Base
@url = "http://contacto.heroku.com/"
 def welcome_email(user)
  recipients user.email
  from "El directorio de companias <no-reply@contacto.com>"
  subject "Bienvenido al directorio de companias"
  sent_on Time.now
 body :user => user
 end
end 
