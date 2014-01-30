class Exercise < ActiveRecord::Base
  attr_accessible :distance, :duration, :outdoor, :type
  
  belongs_to :user
  
  def print_duration
    Time.at(self.duration).utc.strftime("%H:%M:%S")
  end
  
end
