class UsersController < ApplicationController

    def index
    end

    def show
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
    end


private
    def create_update_params
        params.require(:user).permit(:name, :email, :birthday, :is_driver, :encrypted_password)
    end
end
