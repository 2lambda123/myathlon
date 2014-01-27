class SmsController < ApplicationController
  def receive
    @client = Twilio::REST::Client.new ENV["TWILIO_SID"], ENV["TWILIO_TOKEN"]
    process_text(params[:From], params[:Body])
    
    @client.account.messages.create(
      from: '+19795894945',
      to: params[:From],
      body: "Message received - #{params[:Body]}
    )    
  end
end
