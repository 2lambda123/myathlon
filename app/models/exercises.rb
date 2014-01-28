class Exercises < ActiveRecord::Base
  attr_accessible :distance, :duration, :outdoor, :type
  
  belongs_to :user
end
