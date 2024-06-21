class Order < ApplicationRecord
  after_create :send_admin_notification_email
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :items, through: :order_items
  has_one :delivery_info

  def subtotal
    subtotal_amount = order_items.sum { |order_item| order_item.item.price * order_item.quantity }
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
    OrderMailer.success_email(self).deliver_later
  end

  def send_admin_notification_email
    admins = User.where(is_admin: true)
    admins.each do |admin|
      OrderMailer.new_order_email(self, admin).deliver_later
    end
  end
end
