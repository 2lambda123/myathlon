class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :phone, :weight
  
  has_many :weights
  has_many :exercises
  has_many :runs, class_name: "Exercise", conditions: { type: "Run" }
  has_many :bikes, class_name: "Exercise", conditions: { type: "Bike" }
  has_many :swims, class_name: "Exercise", conditions: { type: "Swim" }
  has_many :rests, class_name: "Exercise", conditions: { type: "Rest" }
  
  before_create :convert_phone
  
  private
  def convert_phone
    self.phone = convert_to_e164(self.phone)
  end
  
  def convert_to_e164(raw_phone)
    ActionController::Base.helpers.number_to_phone(
      raw_phone.gsub(/\D/, ""), 
      country_code: 1, 
      delimiter: ""
    )
  end

end
