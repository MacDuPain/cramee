class OrderMailer < ApplicationMailer
  def success_email
    require 'sendgrid-ruby'

    from = SendGrid::Email.new(email: '7vl9emat3@mozmail.com')
    to = SendGrid::Email.new(email: user.email)
    subject = 'Merci pour votre commande !'
    content = SendGrid::Content.new(type: 'text/plain', value: 'Merci d\'avoir passé votre commande chez nous. Nous vous enverrons votre adorable photo de chaton très bientôt.')
    mail = SendGrid::Mail.new(from, subject, to, content)

    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])

    begin
      response = sg.client.mail._('send').post(request_body: mail.to_json)
      puts response.status_code
      puts response.body
      puts response.headers
    rescue Exception => e
      puts e.message
    end
  end

  def send_admin_notification_email
    require 'sendgrid-ruby'

    from = SendGrid::Email.new(email: '7vl9emat3@mozmail.com')
    to = SendGrid::Email.new(email: 'clotilde.abondance@gmail.com')
    subject = 'Nouvelle commande passée'
    file_path = File.join(Rails.root, 'app', 'views', 'order_mailer', 'send_admin_notification_email.html.erb')
    html_content = ERB.new(File.read(file_path)).result(binding)
    content = SendGrid::Content.new(type: 'text/html', value: html_content)
    mail = SendGrid::Mail.new(from, subject, to, content)
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])

    begin
      response = sg.client.mail._('send').post(request_body: mail.to_json)
      puts response.status_code
      puts response.body
      puts response.headers
    rescue Exception => e
      puts e.message
    end
  end
end
