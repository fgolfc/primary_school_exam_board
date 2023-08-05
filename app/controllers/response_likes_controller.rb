class ResponseLikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_response

  def create
    @response_like = current_user.response_likes.find_or_initialize_by(response_id: @response.id)
  
    if @response_like.persisted?
      render json: { status: 'already_exists', message: 'Like already exists.' }, status: :unprocessable_entity
    else
      if @response_like.save
        respond_to do |format|
          format.json { render json: { response_id: @response.id, like_count: @response.response_likes.count } }
        end
      else
        render json: { status: 'error', message: 'Failed to save the like.' }, status: :unprocessable_entity
      end
    end
  end  

  def destroy
    @response_like = current_user.response_likes.find_by(response_id: @response.id)
    if @response_like && @response_like.destroy
      render json: { response_id: @response.id, like_count: @response.response_likes.count }
    else
      render json: { status: 'error', message: 'Failed to delete the like or like not found.' }, status: :unprocessable_entity
    end
  end  

  private

  def set_response
    @response = Response.find(params[:response_id])
  end
end
