class RidesController < ApplicationController

  def create
    @rider = Rider.find(params[:rider_id])
    @driver = Driver.find(params[:drive_id])
    @ride = Ride.new
  end

  def destroy
  end

  def location
  end

  def driver_enroute
  end

  def picked_up
  end

  def dropped_off
  end

  def wait_for_location
  end

  def drive_to_pickup
  end

  def pickup_rider
  end

  def dropoff_rider
  end

end
