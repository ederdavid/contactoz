class Notifier < ActionMailer::Base
  def password_reset_instructions(user)
    subject      "Instrucciones de reseteo de password"
    from         "no-reply@contacto.com"
    recipients   user.email
    content_type "text/html"
    sent_on      Time.now
    body         :edit_password_reset_url => edit_password_reset_url(:id => user.perishable_token, :host => "contacto.heroku.com")
  end
  def activation_instructions(user)
    subject       "Instrucciones de activación"
    from          "no-reply@contacto.com" # Removed name/brackets around 'from' to resolve "555 5.5.2 Syntax error." as of Rails 2.3.3
    recipients    user.email
    sent_on       Time.now
    body          :account_activation_url => activate_url(:activation_code => user.perishable_token, :host => "contacto.heroku.com")
  end
  def welcome(user)
    subject       "¡Bienvenido al directorio de compañías más grande!"
    from          "no-reply@contacto.com"
    recipients    user.email
    sent_on       Time.now
    body          :host => "contacto.heroku.com"
  end
end
