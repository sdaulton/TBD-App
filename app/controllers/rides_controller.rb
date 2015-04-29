class RidesController < ApplicationController

  def create
    #only the rider does this function
    @rider = Rider.find(params["ride"][:rider_id])
    @driver = Driver.find(params["ride"][:driver_id])
    @ride = Ride.new
    @rider.user.ride_as_rider = @ride
    @driver.user.ride_as_driver = @ride
    @rider.destroy
    @driver.destroy

    if @ride.save
      flash[:notice] = "Ride has begun"
      redirect_to(ride_location_path(@ride))
    else 
      flash[:notice] = "Failed to create a ride"
      redirect_to(welcome_user_path(@user))
    end
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
