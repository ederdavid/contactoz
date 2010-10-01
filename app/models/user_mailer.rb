class UserMailer < ActionMailer::Base
 def welcome_email(user)
  recipients user.email
  from "El directorio de companias <no-reply@contacto.com>"
  subject "¡Bienvenido al directorio de compañías más grande!"
  sent_on Time.now
 body :user => user, :url => "http://kontactoz.com/"
 end
 def invite_email(email)
  recipients email
  from "El directorio de companias <no-reply@contacto.com>"
  subject "¡Te han invitado al directorio de compañías más grande!"
  sent_on Time.now
 body :url => "http://kontactoz.com/"
 end

 def feed_email(email, feed)
  recipients email
  from "Destacas de Interes <no-reply@contacto.com>"
  subject feed.name + ": Destacas de Interes "
  sent_on Time.now
 body :url => "http://kontactoz.com//feeds/" + topic.id
 end



end 
