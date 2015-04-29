class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:google_oauth2]

  has_one :driver
  has_one :rider
  has_one :ride_as_driver, class_name:"Ride", foreign_key:"user_d_id"
  has_one :ride_as_rider, class_name:"Ride", foreign_key:"user_r_id"
  #has_one :ride, class_name:"Ride", foreign_key:"user_id"

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:email => data["email"]).first
    if user.nil?
        user = User.create!(name: data["name"],email: data["email"],password: Devise.friendly_token[0,20])
    end
    return user
  end
  
end
