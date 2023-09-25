class Users::SessionsController < Devise::SessionsController

  # def new
  #   super
  # end

  # def create
  #   super

  #   if params[:user][:type] == "guest"
  #     sign_in(:user, Guest.new)
  #     redirect_to root_path, notice: "ゲストとしてログインしました。"
  #   elsif params[:user][:type] == "admin"
  #     sign_in(:user, Admin.new)
  #     redirect_to admin_root_path, notice: "管理者としてログインしました。"
  #   end
  # end

end
