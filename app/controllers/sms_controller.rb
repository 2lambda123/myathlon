class SmsController < ApplicationController
  def receive
    @client = Twilio::REST::Client.new ENV["TWILIO_SID"], ENV["TWILIO_TOKEN"]
    process_text(params[:From], params[:Body])
    
    # @client.account.messages.create(
    #   from: '+19795894945',
    #   to: params[:From],
    #   body: "Message received - #{params[:Body]}"
    # )    
  end
end

=begin
Exercises

Swim - Swim 16x25 20:00
Bike - Bike 5mi 30:00
Run - Run gym 3.2mi 30:00
Rest - Rest

=end