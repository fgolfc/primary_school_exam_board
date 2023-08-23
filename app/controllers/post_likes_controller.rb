class PostLikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post
  before_action :set_post_like, only: :destroy

  def create
    @post_like = current_user.post_likes.find_or_initialize_by(post: @post)
    if @post_like.persisted?
      render js: "alert('You already liked this post!');"
    else
      unless @post_like.save
        render js: "alert('Failed to like the post. Please try again.');"
      end
    end
  end  

  def destroy
    unless @post_like&.destroy
      render js: "alert('Failed to unlike the post. Please try again.');"
    end
  end
  
  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_post_like
    @post_like = current_user.post_likes.find_by(post: @post)
  end
end
