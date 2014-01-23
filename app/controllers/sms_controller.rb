class SmsController < ApplicationController
  def receive
    @client = Twilio::REST::Client.new ENV["TWILIO_SID"], ENV["TWILIO_TOKEN"]
    
    @client.account.messages.create(
      from: '+19795894945',
      to: params[:From],
      body: 'Oh hello!'
    )    
  end
end
