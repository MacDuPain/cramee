class CheckoutController < ApplicationController
  def create
    @order_id = params[:order_id]
    @order = Order.find(@order_id)

    @total = @order.order_items.sum('price * quantity') + calculate_delivery_fee(@order.order_items.sum('price * quantity'))

    @session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [
        {
          price_data: {
            currency: 'eur',
            unit_amount: (@total * 100).to_i,
            product_data: {
              name: 'Rails Stripe Checkout',
            },
          },
          quantity: 1
        }
      ],
      metadata: {
        order_id: @order_id
      },
      mode: 'payment',
      success_url: checkout_success_url + '?session_id={CHECKOUT_SESSION_ID}',
      cancel_url: checkout_cancel_url
    )

    redirect_to @session.url, allow_other_host: true
  end

  def success
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
    @order_id = @session.metadata.order_id
    @order = Order.find(@order_id)

    if @payment_intent.status == 'succeeded'
      @order.mark_as_paid
    end
  end

  def cancel
  end

  private

  def calculate_delivery_fee(total)
    case total
    when 0..20
      4
    when 20..49
      6
    else
      0
    end
  end
end
