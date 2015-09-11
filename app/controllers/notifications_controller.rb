class NotificationsController < ApplicationController
 
  skip_before_action :verify_authenticity_token

 
  def notify

    client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token

    message = client.messages.create from: '+15005550006', to: '+447960577601', body: 'Learning to send SMS you are.'

    if message.status == 'queued'
      render plain: 'twilio is working'
      # puts 'success'
    else
      render plain: 'its brokes'
      # puts 'fail'
    end
  end

  
end