class ResponseLikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_response
  before_action :set_response_like, only: :destroy

  def create
    @response_like = current_user.response_likes.find_or_initialize_by(response: @response)
    if @response_like.persisted?
      render js: "alert('You already liked this response!');" 
    else
      unless @response_like.save
        render js: "alert('Failed to like the response. Please try again.');"
      end
    end
  end

  def destroy
    unless @response_like&.destroy
      render js: "alert('Failed to unlike the response. Please try again.');"
    end
  end
  
  private

  def set_response
    @response = Response.find(params[:response_id])
  end

  def set_response_like
    @response_like = current_user.response_likes.find_by(response: @response)
  end
end
