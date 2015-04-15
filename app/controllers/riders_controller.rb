class RidersController < ApplicationController

  def create
    @user = User.find(params[:user_id])
    
    #build sets the product foreign key automatically
    @rider = Rider.new
    @user.rider = @rider

    if @rider.save
      flash[:notice] = 'You are now waiting for a driver to become available.'
      redirect_to(user_rider_wait_path(@user, @rider))
    else
      flash[:notice] = "Failed to request a ride.  Please try again"
      redirect_to(welcome_user_path(@user))
    end

  end

  def destroy
    @rider = Rider.find(params[:id])
    @user = User.find(@rider.user_id)
    @rider.destroy
    flash[:notice] = "Not waiting for a ride."
    redirect_to(welcome_user_path(@user))
  end

  def wait
    @num_ahead = num - 1
    @num_drivers = Driver.count
  end

  def first
    @rider = Rider.first
    @user = User.find(@rider.user_id)
  end

  def num
    Rider.count 
  end

end
