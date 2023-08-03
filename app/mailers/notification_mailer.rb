class NotificationMailer < ApplicationMailer
  def notify_admin(notification)
    @notification = notification
    mail(to: 'cf.ts.fujimoto@gmail.com', subject: '投稿NG通知')
  end
end
