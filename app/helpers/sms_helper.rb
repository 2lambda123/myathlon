module SmsHelper
  def process_text(from, message)
    user = User.find_by_phone(from)
    message_parts = message.split
    type = get_type(message_parts[0].downcase)
    
    case type
    when "Weight"
      user.weights.build(weight: message_parts[1])
    when "Run", "Swim", "Bike"
      swim_distance = message_parts.grep(/\d+x\d+/)[0]
      distance = swim_distance ? convert_swim_distance(swim_distance) : message_parts.grep(/.+(?=mi)/)[0][0...-2]
      outdoor = !message_parts.include?("gym")
      duration = convert_to_seconds(message_parts.grep(/\d+:\d+(:\d+)?/)[0])
      
      user.exercises.build(distance: distance, duration: duration, outdoor: outdoor, type: type)
    when "Rest"
      user.exercises.build(type: type)
    end
    
    user.save!
  end
    
  def convert_swim_distance(distance)
    nums = distance.split("x")
    (nums[0].to_i * nums[1].to_i).meters.to.miles.to_f.round(2) #for those keeping score at home, 7 periods
  end
  
  def convert_to_seconds(duration)
    duration_parts = duration.split(":")
    duration_parts.pop.to_i + duration_parts.pop.to_i.minutes + duration_parts.pop.to_i.hours 
  end

  def get_type(type)
    types = {
      "ru" => "Run",    "run" => "Run",
      "b"  => "Bike",   "bike" => "Bike",
      "s"  => "Swim",   "swim" => "Swim", 
      "re" => "Rest",   "rest" => "Rest",
      "w"  => "Weight", "weight" => "Weight" }
    types[type]
  end
  
end

=begin
message formats

Swim - "Swim 16x25 01:20:00"
Bike - "Bike 5mi 30:00"
Run - "Run gym 3.2mi 30:00"
Rest - "Rest"
Weight - "Weight 170.0"

=end