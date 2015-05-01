class UsersController < ApplicationController

    def index
    end

    def show
        id = params[:id]
        @user = User.find(id)
    end

    def new
    end

    def edit
        id = params[:id]
        @user = User.find(id)
    end
  
    def update
        @user = User.find params[:id]
        @user.update(create_update_params)
        flash[:notice] = "#{@user.name} was successfully updated"
        redirect_to welcome_user_path(@user)

    end
    
    def welcome
        id = params[:id]
        @user = User.find(id)
        @user_is_a_driver = @user.is_driving
    end


private
    def create_update_params
        params.require(:user).permit(:name, :email, :birthday, :is_driving, :is_riding, :driver_license, :driver_license_sate, :license_place, :license_plate_state, :make, :model, :year, :encrypted_password)
    end
end
