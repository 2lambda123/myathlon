class Exercise < ActiveRecord::Base
  attr_accessible :distance, :duration, :outdoor, :type
  
  belongs_to :user
  has_many :runs
  has_many :rests
  has_many :bikes
  has_many :swims
  
  def print_duration
    Time.at(self.duration).utc.strftime("%H:%M:%S")
  end
  
end
