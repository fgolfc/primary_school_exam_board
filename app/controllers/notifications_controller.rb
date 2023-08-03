class NotificationsController < ApplicationController
  def create
    @notification = Notification.new(notification_params)
    if @notification.save
      NotificationMailer.notify_admin(@notification).deliver_now
      render json: { message: '通知が作成されました' }
    else
      render json: { message: '通知の作成に失敗しました' }, status: :unprocessable_entity
    end
  end

  private

  def notification_params
    # :commentはデータベースのカラムではない場合、通知内容として:actionに設定するか、適切に処理してください。
    params.permit(:user_id, :post_id, :action, :checked)
  end
end
