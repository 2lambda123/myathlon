module SmsHelper
  def process_text(from, message)
    message_parts = message.split
    user = User.find_by_phone(from)
    
    outdoor = !message_parts.include?("gym")
    duration = message_parts.grep(/\d{2}:\d{2}/)[0]
    swim_distance = message_parts.grep(/\d+x\d+/)[0]
    
    distance = swim_distance ? convert_swim_distance(swim_distance) : message_parts.grep(/.+mi/)[0]
    
    case message_parts[0].downcase
    when "weight" || "w"
      user.weights.build(weight: message_parts[1])
    when "run" || "r"
      
    end
    
    user.save!
  end
  
  def convert_swim_distance(distance)
    nums = distance.split("x")
    (nums[0].to_i * nums[1].to_i).meters.to.miles.to_f.round(2) #for those keeping score at home, 7 periods
  end
end



=begin
Exercises

Swim - Swim 16x25 20:00
Bike - Bike 5mi 30:00
Run - Run gym 3.2mi 30:00
Rest - Rest

=end