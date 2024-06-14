class CheckoutController < ApplicationController
  # Action pour créer une session de paiement Stripe
  def create
    @order_id = params[:order_id]
    @order = Order.find(@order_id)

    # Calcul du total de la commande incluant les frais de livraison
    @total = @order.order_items.sum('price * quantity') + calculate_delivery_fee(@order.order_items.sum('price * quantity'))

    # Création d'une session de paiement Stripe
    @session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [
        {
          price_data: {
            currency: 'eur',
            unit_amount: (@total * 100).to_i, # Le montant total converti en centimes
            product_data: {
              name: 'Rails Stripe Checkout', # Nom du produit dans Stripe
            },
          },
          quantity: 1
        }
      ],
      metadata: {
        order_id: @order_id # Métadonnées de la commande pour référence
      },
      mode: 'payment', # Mode de la session : paiement
      success_url: checkout_success_url + '?session_id={CHECKOUT_SESSION_ID}', # URL de redirection en cas de succès
      cancel_url: checkout_cancel_url # URL de redirection en cas d'annulation du paiement
    )

    # Rediriger l'utilisateur vers l'URL de paiement Stripe
    redirect_to @session.url, allow_other_host: true
  end

  # Action appelée après un paiement réussi
  def success
    @session = Stripe::Checkout::Session.retrieve(params[:session_id]) # Récupérer la session Stripe
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent) # Récupérer l'intent de paiement associé
    @order_id = @session.metadata.order_id # Récupérer l'ID de la commande depuis les métadonnées
    @order = Order.find(@order_id) # Trouver la commande associée

    # Marquer la commande comme payée si le paiement a réussi
    if @payment_intent.status == 'succeeded'
      @order.mark_as_paid
    end
  end

  # Action appelée en cas d'annulation du paiement
  def cancel
  end

  private

  # Méthode privée pour calculer les frais de livraison en fonction du total de la commande
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
