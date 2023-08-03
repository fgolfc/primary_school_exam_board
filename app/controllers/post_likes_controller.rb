class PostLikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    @post_like = current_user.post_likes.find_or_initialize_by(post: @post)

    if @post_like.persisted?
      # The like already exists. Do nothing, or show a message to the user.
    else
      if @post_like.save
        # Like was successfully created. Update the page or show a success message.
      else
        # An error occurred when trying to save the like. Show an error message.
      end
    end
  end

  def destroy
    @post_like = current_user.post_likes.find_by(post: @post)
    if @post_like && @post_like.destroy
      respond_to do |format|
        format.html { redirect_back fallback_location: root_path }
        format.js { @status = "destroy" }
      end
    else
      # Handle not found like here
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
