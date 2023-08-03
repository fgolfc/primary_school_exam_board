class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_likeable

  def create
    @like = current_user.likes.find_or_initialize_by(likeable: @likeable)

    if @like.persisted?
      # The like already exists. Do nothing, or show a message to the user.
    else
      if @like.save
        # Like was successfully created. Update the page or show a success message.
      else
        # An error occurred when trying to save the like. Show an error message.
      end
    end
  end

  def destroy
    @like = current_user.likes.find_by(likeable: @likeable)
    if @like && @like.destroy
      respond_to do |format|
        format.html { redirect_back fallback_location: root_path }
        format.js { @status = "destroy" }
      end
    else
      # Handle not found like here
    end
  end

  private

  def set_likeable
    @likeable = params[:likeable_type].constantize.find(params[:likeable_id])
  end 
end
