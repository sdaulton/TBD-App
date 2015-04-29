class Ride < ActiveRecord::Base

  has_one :rider, class_name:"User", foreign_key: "user_r_id"
  has_one :driver, class_name:"User", foreign_key: "user_d_id"

end
