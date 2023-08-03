class PostMailer < ApplicationMailer
  def post_deleted(post, user)
    @post = post
    @user = user
    mail(
      subject: '投稿が削除されました',
      to: user.email
    )
  end
end
