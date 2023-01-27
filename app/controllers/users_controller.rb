class UsersController < ApplicationController

before_action :require_signin, except: [:new, :create]
before_action :require_current_user, only: [:edit, :update, :destroy]

  def index
    @users = User.all
end

def show
    @user = User.find(params[:id])
end

def new
    @user = User.new
end

def create
    @user = User.new(user_params)
    if @user.save 
        session[:user_id] = @user.id
        redirect_to user_path(@user), notice: "Thanks for signing up!"
    else
      render :new, status: :unprocessable_entity

    end
end

def edit
    
  end

def update
    
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "Account successfully updated!"
    else
      render :edit, status: :unprocessable_entity
    end
end  
  
  def destroy
    @user.destroy
    session[:user_id] = nil
    redirect_to root_path, status: :see_other,
      alert: "Account successfully deleted!"
  end

private

    def user_params
        params.require(:user).
        permit(:name, :email, :password, :password_confirmation, :username)
    end

    def require_current_user
      @user = User.find(params[:id])
       unless current_user?(@user)
        redirect_to root_url, status: :see_other
      end
    end

end

