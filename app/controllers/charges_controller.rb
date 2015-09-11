class ChargesController < ApplicationController

  skip_before_action :verify_authenticity_token


  def create
    @promotion = Promotion.find(params[:promotion_id])
    @amount = @promotion.price*100

    business_number = @promotion.user.valid_tel
    customer_number = current_user.valid_tel

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :card  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount.to_i,
      :description => @promotion.pitch,
      :currency    => 'gbp'
    )

    client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token

    customer_response = send_customer_text(client, customer_number)
    business_response = send_business_text(client, business_number)

    logger.info "customer response is " + customer_response.status
    logger.info "business response is " + business_response.status

  rescue Stripe::CardError => e
    flash[:error] = e.message
  ensure
    @promotion.buyers += 1
    @promotion.save
    redirect_to confirmed_promotion_path(@promotion)
  end

  def send_customer_text(client, customer_number)
    client.messages.create(
    from: '+441904500767',
    to: customer_number,
    body: "Thank you for making an order with GetLunch, your order of #{@promotion.pitch}, will be ready for collection in 20mins.
      #{@promotion.user.name} 
      #{@promotion.user.address}
      #{@promotion.user.postcode}"
    )
  end

  def send_business_text(client, business_number)
    client.messages.create(
    from: '+441904500767',
    to: business_number,
    body: "#{current_user.name} has just ordered #{@promotion.pitch}"
    )
  end
  
end
