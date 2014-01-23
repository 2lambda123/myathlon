class SmsController < ApplicationController
  def receive
    sender = params[:From]
    @twiml = Twilio::TwiML::Response.new do |r|
        r.Message "Hey Monkey. Thanks for the message! Your number is #{sender}."
    end
    @twiml.text
  end
end
