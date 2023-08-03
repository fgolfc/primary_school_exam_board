class PostMailer2 < ApplicationMailer
  default to: "cf.ts.f.uj.im.oto@gmail.com"

  def notify_post_admin
    @post = params[:post]
    @comment = params[:comment]

    mail(subject: "新たな投稿通知")
  end
end
