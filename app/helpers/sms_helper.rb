module SmsHelper
  def process_text(from, message)
    user = User.find_by_phone(from)
    message_parts = message.split
    
    swim_distance = message_parts.grep(/\d+x\d+/)[0]
    distance = swim_distance ? convert_swim_distance(swim_distance) : message_parts.grep(/.+(?=mi)/)[0][0...-2]
    
    outdoor = !message_parts.include?("gym")
    duration = message_parts.grep(/\d{2}:\d{2}/)[0]
    type = get_type(message_parts[0].downcase)
    
    
    case type
    when "weight"
      user.weights.build(weight: message_parts[1])
    when "run" || "swim" || "bike" || "rest"
      p distance
      p duration
      p outdoor
      p type
      user.exercises.build(distance: distance, duration: duration, outdoor: outdoor, type: type)
    end
    
    user.save!
  end
  
  def convert_swim_distance(distance)
    nums = distance.split("x")
    (nums[0].to_i * nums[1].to_i).meters.to.miles.to_f.round(2) #for those keeping score at home, 7 periods
  end

  def get_type(type)
    types = {
      "ru" => "run",    "run" => "run",
      "b"  => "bike",   "bike" => "bike",
      "s"  => "swim",   "swim" => "swim", 
      "re" => "rest",   "rest" => "rest",
      "w"  => "weight", "weight" => "weight" }
    types[type]
  end
  
end

=begin
message formats

Swim - Swim 16x25 00:20:00
Bike - Bike 5mi 30:00
Run - Run gym 3.2mi 30:00
Rest - Rest
Weight - Weight 170.0

=end