class UserMailer < ActionMailer::Base
 def welcome_email(user)
  recipients user.email
  from "El directorio de companias <no-reply@eldirectorio.com>"
  subject "Bienvenido al directorio de companias"
  sent_on Time.now
 body :user => user
 end
end 
