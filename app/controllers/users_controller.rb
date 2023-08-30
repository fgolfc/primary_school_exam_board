class UsersController < ApplicationController
  before_action :set_user, only: [:show, :destroy]
  before_action :authorize_user, only: [:show]
  before_action :authorize_admin, only: [:destroy]

  def show
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :nickname, :prefecture, :admin) 
  end
  

  def set_user
    @user = User.find(params[:id])
  end

  def authorize_user
    unless current_user && (current_user == @user || current_user.admin?)
      redirect_to root_path, alert: "You do not have permission to access this page."
    end
  end

  def authorize_admin
    unless current_user&.admin?
      redirect_to root_path, alert: "Only admins can perform that action."
    end
  end
end
