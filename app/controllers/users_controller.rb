class UsersController < ApplicationController

    def index
    end

    def show
    end

    def new
    end

    def register
    end
    
    def login
    end

    def logging
        email = params[:email]
        @user = User.find_by email: email
        redirect_to welcome_user_path(@user)
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

    def create
        redirect_to user_omniauth_authorize_path(:google_oauth2)
    end

private
    def create_update_params
        params.require(:user).permit(:name, :email, :birthday, :driver, :encrypted_password)
    end
end
