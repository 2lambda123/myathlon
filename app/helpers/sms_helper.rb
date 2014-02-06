module SmsHelper
  def process_text(from, message)
    user = User.find_by_phone(from) #User.find_by phone: from in Rails 4
    message_parts = message.split
    type = get_type(message_parts[0].downcase)
    
    case type
    when "Weight"
      user.weights.build(weight: message_parts[1])
      return user.save!
    when "Run", "Swim", "Bike"
      swim_distance = message_parts.grep(/\d+x\d+/)[0]
      distance = swim_distance ? convert_swim_distance(swim_distance) : message_parts.grep(/.+(?=mi)/)[0][0...-2]
      outdoor = !message_parts.include?("gym")
      duration = convert_to_seconds(message_parts.grep(/\d+:\d+(:\d+)?/)[0])
    when "Nike"
      #right now built for runs, need to look at returned data for others
      #also appears that nike token is unique to my nike+ ID
      run_data = NikeV2::Person.new(access_token: ENV["NIKE_TOKEN"]).activities.first
      distance = convert_metric_distance(run_data.metric_summary["distance"], 1000)
      duration = convert_to_seconds(run_data.metric_summary["duration"])
      outdoor = run_data.tags[0]["tagValue"] == "OUTDOORS"
      type = run_data.activity_type.capitalize
    end
    
    user.exercises.build(distance: distance, duration: duration, outdoor: outdoor, type: type)
    user.save!
  end

  private

  def convert_metric_distance(distance, multiplier = 1)
    distance.meters.to.miles.to_f.round(2) * multiplier
  end
    
  def convert_swim_distance(distance)
    nums = distance.split("x")
    convert_metric_distance((nums[0].to_i * nums[1].to_i))
  end
  
  def convert_to_seconds(duration)
    duration_parts = duration.split(":")
    duration_parts.pop.to_i + duration_parts.pop.to_i.minutes + duration_parts.pop.to_i.hours 
  end

  def get_type(type)
    types = {
      "r"  => "Run",     "ru" => "Run",    "run" => "Run",
      "b"  => "Bike",   "bike" => "Bike",
      "s"  => "Swim",   "swim" => "Swim", 
      "re" => "Rest",   "rest" => "Rest",
      "w"  => "Weight", "weight" => "Weight",
      "n"  => "Nike",   "nike" => "Nike"}
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
Nike - "Nike"

=end