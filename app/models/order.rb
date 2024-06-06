class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :items, through: :order_items
  has_one :delivery_info

  def mark_as_paid
    update(status: 'succeeded')
    send_emails if saved_change_to_status? && status == 'succeeded'
  end

  private

  def send_emails
    success_email
    send_admin_notification_email
  end

  def success_email
    require 'sendgrid-ruby'

    from = SendGrid::Email.new(email: '7vl9emat3@mozmail.com')
    to = SendGrid::Email.new(email: user.email)
    subject = 'Merci pour votre commande !'
    file_path = File.join(Rails.root, 'app', 'views', 'order_mailer', 'success_email.html.erb')
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
