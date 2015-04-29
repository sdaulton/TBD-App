class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:google_oauth2]

  has_one :driver
  has_one :rider
  belongs_to :ride

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:email => data["email"]).first
    if user.nil?
        user = User.create!(name: data["name"],email: data["email"],password: Devise.friendly_token[0,20])
    end
    return user
  end
  
end
