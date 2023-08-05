class PostLikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    @post_like = current_user.post_likes.find_or_initialize_by(post: @post)
  
    if @post_like.persisted?
      render json: { status: 'already_exists', message: 'Like already exists.' }, status: :unprocessable_entity
    else
      if @post_like.save
        respond_to do |format|
          format.json { render json: { post_id: @post.id, like_count: @post.post_likes.count } }
        end
      else
        render json: { status: 'error', message: 'Failed to save the like.' }, status: :unprocessable_entity
      end
    end
  end  

  def destroy
    @post_like = current_user.post_likes.find_by(post: @post)
    if @post_like && @post_like.destroy
      render json: { post_id: @post.id, like_count: @post.post_likes.count }
    else
      render json: { status: 'error', message: 'Failed to delete the like or like not found.' }, status: :unprocessable_entity
    end
  end    

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
