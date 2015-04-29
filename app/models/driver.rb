class Driver < ActiveRecord::Base
  belongs_to :user

  def rider_available?
    Rider.count >= 1
  end

end
