class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :items, through: :order_items
  has_one :delivery_info

  def subtotal
    subtotal_amount = order_items.sum { |order_item| order_item.item.price * order_item.quantity }
    puts "Subtotal: #{subtotal_amount}" # Ajoutez ce journal de débogage
    subtotal_amount
  end

  def delivery_fee
    subtotal_amount = subtotal
    case subtotal_amount
    when 0..20
      fee = 4
    when 20..49
      fee = 6
    else
      fee = 0
    end
    puts "Delivery Fee: #{fee}" # Ajoutez ce journal de débogage
    fee
  end

  def total_price
    subtotal_amount = subtotal
    delivery_fee_amount = delivery_fee
    total = subtotal_amount + delivery_fee_amount
    puts "Total Price: #{total}" # Ajoutez ce journal de débogage
    total
  end

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
