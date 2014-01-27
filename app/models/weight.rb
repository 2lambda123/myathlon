class Weight < ActiveRecord::Base
  attr_accessible :weight
  belongs_to :user
end
