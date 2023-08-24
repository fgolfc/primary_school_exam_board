class NotificationMailer < ApplicationMailer
  def notify_admin(notification)
    @notification = notification
    @user = @notification.user
    @post = @notification.post
    mail(to: 'cf.ts.fujimoto@gmail.com', subject: '投稿通報連絡')
  end
end
