class NotificationMailer < ApplicationMailer
  def notify_admin(notification)
    @notification = notification
    @user = User.find(@notification.user_id)
    @post = Post.find(@notification.post_id)
    mail(to: 'cf.ts.fujimoto@gmail.com', subject: '投稿通報連絡')
  end
end
