class Rider < ActiveRecord::Base
  belongs_to :user

  def driver_available?
    Driver.count >= 1 
  end

end
