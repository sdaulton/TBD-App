class UsersController < ApplicationController

    def index
    end

    def show
    end

    def new
    end

    def register
      @empty_user = User.new
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
		  byebug
        user = User.new(create_update_params)
		  redirect_to user_omniauth_authorize_path(:google_oauth2)
        #if user.save
        #    flash[:notice] = "New user #{u.name} created successfully"
        #    redirect_to users_path
        #else
        #    flash[:warning] = "User couldn't be created"
        #    redirect_to new_user_path
        #end
    end

private
    def create_update_params
        params.require(:user).permit(:name, :email, :encrypted_password)
    end
end
