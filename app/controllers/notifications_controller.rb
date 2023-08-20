class NotificationsController < ApplicationController
  def create
    @notification = Notification.new(notification_params)
    if @notification.save
      @user = @notification.user
      NotificationMailer.notify_admin(@notification).deliver_now
      render json: { status: 'success', message: '通知が成功しました' }
    else
      render json: { status: 'error', message: @notification.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def notification_params
    params.permit(:user_id, :post_id, :comment)
  end  
end
