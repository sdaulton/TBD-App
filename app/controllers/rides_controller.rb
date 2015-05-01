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

  def update_location
    @ride = Ride.find params[:ride_id]
    @ride.update(create_update_params)
    redirect_to ride_driver_enroute_path(@ride)
  end

  def update_drive_to_pickup
	 @ride = Ride.find(params[:ride_id])
	 @ride.driver_at_pickup = true
	 @ride.save
	 redirect_to ride_pickup_rider_path(@ride)
  end

  def update_pickup_rider
	 @ride = Ride.find(params[:ride_id])
	 @ride.driver_pickup_confirm = true
	 @ride.save
	 redirect_to ride_wait_for_rider_confirm_path(@ride)
  end

  def update_picked_up
	 @ride = Ride.find(params[:ride_id])
	 @ride.rider_pickup_confirm = true
	 @ride.save
	 redirect_to ride_wait_for_driver_confirm_path(@ride)
  end

  def update_dropoff_rider
	 @ride = Ride.find(params[:ride_id])
	 @ride.driver_dropoff_confirm = true
	 @ride.save
	 @user = User.find(@ride.user_d_id)
	 redirect_to ride_wait_for_rider_dropoff_confirm_path(@ride, :user_id=>@user) and return 
  end

  def update_dropped_off
	 @ride = Ride.find(params[:ride_id])
	 @ride.rider_dropoff_confirm = true
	 @ride.save
	 @user = User.find(@ride.user_r_id)
	 redirect_to ride_wait_for_driver_dropoff_confirm_path(@ride, :user_id=>@user) and return
  end

  def location
    if params[:ride_id]
      id = params[:ride_id]
    else
      id = params[:id]
    end
    @ride = Ride.find(id)
    @user = User.find([@ride.user_r_id]).first
  end

  def driver_enroute
    @ride = Ride.find(params[:ride_id])
    @driver = User.find(@ride.user_d_id)
	 if @ride.driver_at_pickup
		redirect_to ride_picked_up_path(@ride)
    end
  end

  def picked_up
	 @ride = Ride.find(params[:ride_id])
  end

  def dropped_off
	 @ride = Ride.find(params[:ride_id])
  end

  def dropoff_rider
	 @ride = Ride.find(params[:ride_id])
  end

  def wait_for_location
	 @ride = Ride.find(params[:ride_id])
	 if @ride.start_location && @ride.end_location
	 	redirect_to ride_drive_to_pickup_path(@ride)
	 end	 
  end

  def drive_to_pickup
	 @ride = Ride.find(params[:ride_id])
  end

  def pickup_rider
	 @ride = Ride.find(params[:ride_id])
  end

  def wait_for_driver_confirm
	 @ride = Ride.find(params[:ride_id])
	 if @ride.driver_pickup_confirm
	   redirect_to ride_dropped_off_path(@ride)
	 end
  end

  def wait_for_rider_confirm
	 @ride = Ride.find(params[:ride_id])
	 if @ride.rider_pickup_confirm
	 	redirect_to ride_dropoff_rider_path(@ride)
	 end
  end

  def wait_for_driver_dropoff_confirm
	 @ride = Ride.find(params[:ride_id])
	 @user = User.find(params[:user_id])
	 if @ride.driver_dropoff_confirm
		@ride.destroy
   	redirect_to(welcome_user_path(@user))
	 end
  end

  def wait_for_rider_dropoff_confirm
	 @ride = Ride.find(params[:ride_id])
	 @user = User.find(params[:user_id])
	 if @ride
	 	if @ride.rider_dropoff_confirm
    	  redirect_to(welcome_user_path(@user))
	 	end
	 else
      redirect_to(welcome_user_path(@user))  
	 end
  end

private 
  def create_update_params
    params.require(:ride).permit(:start_location,:end_location)
  end
end
