class NotificationsController < ApplicationController
  def create
    @notification = Notification.new(notification_params)
    if @notification.save
        respond_to do |format|
            format.html { redirect_to posts_url }
            format.js   # <-- JSフォーマットの追加
        end
    else
        respond_to do |format|
            format.html { render :new }
            format.js   # <-- JSフォーマットの追加
        end
    end
  end  

  private

  def notification_params
    params.permit(:user_id, :post_id, :action, :checked, :comment)
  end  
end
