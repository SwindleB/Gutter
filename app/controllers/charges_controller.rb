class ChargesController < ApplicationControlle
    
    def new
    end
    
    def create
      # Amount in cents
     
    
      customer = Stripe::Customer.create(
        :email => params[:stripeEmail],
        :source  => params[:stripeToken]
      )
    
      charge = Stripe::Charge.create(
        :customer    => customer.id,
        :amount      => params['amount'],
        :description => 'Rails Stripe customer',
        :currency    => 'usd'
      )
     puchase = Purchase.create(email: params[:stripeEmail], card: params[:stripeToken], amount: params[:amount], description: charge.descrition, currency: charge.currency,
     customer_id: customer.id, product_id: 1) 
     
     redirect_to purchase
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
    end
end