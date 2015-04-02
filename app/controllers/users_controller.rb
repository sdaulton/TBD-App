class UsersController < ApplicationController

    def index
    end

    def show
        id = params[:id]
        @user = User.find(id)
    end

    def new
    end
    
    def create
        u = User.new(create_update_params)
        if u.save
            flash[:notice] = "New user #{u.name} created successfully"
            redirect_to users_path
        else
            flash[:warning] = "User couldn't be created"
            redirect_to new_user_path
        end
    end

private
    def create_update_params
        params.require(:user).permit(:name, :email, :encrypted_password)
    end
end
