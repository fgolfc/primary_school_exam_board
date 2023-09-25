class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :ensure_normal_user, only: %i[create update destroy]

  def ensure_normal_user
    if params[:user] && params[:user][:email]&.downcase == 'guest@example.com'
      action_specific_message = action_name == "create" ? "ゲストユーザーとしての新規登録はできません。" : "ゲストユーザーの更新・削除はできません。"
      redirect_to new_user_session_path, alert: action_specific_message
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :prefecture])
    devise_parameter_sanitizer.permit(:account_update, keys: [:nickname, :prefecture])
  end  
end
