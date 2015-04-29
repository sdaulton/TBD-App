class DriversController < ApplicationController

  def create
    @user = User.find(params[:user_id])
    if @user.driver
      # user is already ready to drive
      flash[:notice] = 'You have already made yourself available to drive'
      @driver = @user.driver
      redirect_to(user_driver_wait_path(@user, @driver)) and return
    end
    #build sets the product foreign key automatically
    @driver = Driver.new
    @user.driver = @driver

    if @driver.save
      flash[:notice] = 'You are now waiting for a rider.'
      redirect_to(user_driver_wait_path(@user, @driver))
    else
      flash[:notice] = "Failed to add you as an available driver.  Please try again"
      redirect_to(welcome_user_path(@user))
    end

  end

  def destroy
    @driver = Driver.find(params[:id])
    @user = User.find(@driver.user_id)
    @driver.destroy
    flash[:notice] = "Driver inactive"
    redirect_to(welcome_user_path(@user))
  end

  def wait
    @num_ahead = num - 1
    @user = User.find(params[:user_id])
    @driver = @user.driver
    if @user.ride_as_driver
      redirect_to(ride_wait_for_location_path(@user.ride_as_driver))
    end
  end

  def first
    @driver = Driver.first
    @user = User.find(@driver.user_id)
  end

  def num
    Driver.count 
  end

end
