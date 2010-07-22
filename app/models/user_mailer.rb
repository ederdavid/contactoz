class UserMailer < ActionMailer::Base
 def welcome_email(user)
  recipients user.email
  from "El directorio de companias <no-reply@contacto.com>"
  subject "¡Bienvenido al directorio de compañías más grande!"
  sent_on Time.now
 body :user => user, :url => "http://contacto.heroku.com/"
 end
 def invite_email(user)
  recipients user
  from "El directorio de companias <no-reply@contacto.com>"
  subject "¡Te han invitado al directorio de compañías más grande!"
  sent_on Time.now
 body :url => "http://contacto.heroku.com/"
 end
end 
