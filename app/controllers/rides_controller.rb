class RidesController < ApplicationController

  def create
    #only the rider does this function
    byebug
    @rider = Rider.find(params["ride"][:rider_id])
    @driver = Driver.find(params["ride"][:driver_id])
    @ride = Ride.new
    @rider.user.ride_as_rider = @ride
    @driver.user.ride_as_driver = @ride
    @rider.destroy
    @driver.destroy

    params[:ride_id] = @ride.id

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

  def edit
  end

  def update
    byebug
    @ride = Ride.find params[:id]
    @ride.update(create_update_params)
    if params["ride"]["current_page"]=="location"
      redirect_to ride_driver_enroute_path(@ride)
    end
  end

  def location
    byebug
    if params[:ride_id]
      id = params[:ride_id]
    else
      id = params[:id]
    end
    @ride = Ride.find(id)
    @user = User.find([@ride.user_r_id]).first
  end

  def driver_enroute
    byebug
    @ride = Ride.find(params[:ride_id])
    @driver = User.find(@ride.user_d_id)
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

private 
  def create_update_params
    params.require(:ride).permit(:start_location,:end_location)
  end
end
