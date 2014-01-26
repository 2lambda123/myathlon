class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :phone
  
  has_many :weights
  
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
