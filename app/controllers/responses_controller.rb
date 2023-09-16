class ResponsesController < ApplicationController
  before_action :set_response, only: %i[ show edit update destroy ]

  # GET /responses or /responses.json
  def index
    @responses = Response.all
  end

  # GET /responses/1 or /responses/1.json
  def show
  end

  # GET /responses/new
  def new
    @post = Post.find(params[:post_id])
    @response = Response.new
  end

  # GET /responses/1/edit
  def edit
  end

  # POST /responses or /responses.json
  def create
    @post = Post.find(params[:response][:post_id])
    @response = @post.responses.build(response_params)
    @response.user = current_user
  
    respond_to do |format|
      if @response.save
        format.html { redirect_to post_path(@post) }
        format.json { render :show, status: :created, location: @response }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @response.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /responses/1 or /responses/1.json
  def update
    respond_to do |format|
      if @response.update(response_params)
        format.html { redirect_to response_url(@response), notice: "Response was successfully updated." }
        format.json { render :show, status: :ok, location: @response }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @response.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /responses/1 or /responses/1.json
  def destroy
  @response = Response.find(params[:id])
  @post = @response.post

  if @post.nil?
    # ここでエラーハンドリング。例えば、root_pathにリダイレクトさせる。
    redirect_to root_url, alert: "Post not found."
    return
  end

  @response.destroy

  respond_to do |format|
    format.html { redirect_to post_url(@post), notice: "Response was successfully destroyed." }
    format.json { head :no_content }
  end
end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_response
      @response = Response.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def response_params
      params.require(:response).permit(:body, :post_id)
    end
end
