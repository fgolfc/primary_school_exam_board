class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post_or_response

  def create
    if @post
      @like = current_user.likes.find_or_initialize_by(post: @post)
    elsif @response
      @like = current_user.likes.find_or_initialize_by(response: @response)
    end

    if @like.persisted?
      # The like already exists. Do nothing, or show a message to the user.
    else
      if @like.save
        target = @post || @response
        render json: { id: target.id, like_count: target.likes.count }
      else
        # An error occurred when trying to save the like. Show an error message.
      end
    end
  end

  def destroy
    if @post
      @like = current_user.likes.find_by(post: @post)
    elsif @response
      @like = current_user.likes.find_by(response: @response)
    end

    if @like && @like.destroy
      target = @post || @response
      respond_to do |format|
        format.html { redirect_back fallback_location: root_path }
        format.json { render json: { id: target.id, like_count: target.likes.count } }
      end
    else
      # Handle not found like here
    end
  end  

  private

  def set_post_or_response
    if params[:post_id]
      @post = Post.find(params[:post_id])
    elsif params[:response_id]
      @response = Response.find(params[:response_id])
    end
  end 
end
