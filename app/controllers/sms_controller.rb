class SmsController < ApplicationController
  def receive
    @client = Twilio::REST::Client.new ENV["TWILIO_SID"], ENV["TWILIO_TOKEN"]
    
    sender = params[:From]
    @twiml = Twilio::TwiML::Response.new do |r|
        r.Message "Hey Monkey. Thanks for the message! Your number is #{sender}."
    end
    
    @client.account.messages.create(
      from: '+19795894945',
      to: params[:From],
      body: 'Oh hello!'
    )
    
    @twiml.text
  end
end
