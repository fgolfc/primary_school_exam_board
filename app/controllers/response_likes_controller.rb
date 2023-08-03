class ResponseLikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_response

  def create
    @response_like = current_user.response_likes.find_or_initialize_by(response_id: @response.id)

    if @response_like.persisted?
      # いいねがすでに存在する場合の処理（必要に応じて）
    else
      if @response_like.save
        # いいねが成功した場合の処理（例：Ajaxを使ってビューを更新など）
      else
        # いいねの保存に失敗した場合の処理
      end
    end
  end

  def destroy
    @response_like = current_user.response_likes.find_by(response_id: @response.id)
    if @response_like && @response_like.destroy
      # いいねの削除が成功した場合の処理（例：ページをリダイレクトやAjaxでのビューの更新など）
    else
      # いいねが見つからない、または削除に失敗した場合の処理
    end
  end

  private

  def set_response
    @response = Response.find(params[:response_id])
  end
end
