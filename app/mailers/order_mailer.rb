class OrderMailer < ApplicationMailer

  default from: 'noreply@lesmondesdemisscramee.fr'


  def new_order_email(order, admin)
    @order = order
    @admin = admin
    @url  = 'http://mondesmisscramee.com/admin/orders'
    mail(to: @admin.email, subject: 'New Order Notification')
  end

  def success_email(order)
    @order = order
    @url  = 'http://mondesmisscramee.com/login'
    mail(to: @order.user.email, subject: 'Merci pour votre commande !')
  end
end
