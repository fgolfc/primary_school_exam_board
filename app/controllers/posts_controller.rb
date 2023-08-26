class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_post, only: %i[ show edit update destroy ]

  # GET /posts or /posts.json
  def index
    @q = Post.ransack(params[:q])

    base_query = @q.result.includes(:user, :post_likes, :responses)

    if params[:order_by] == 'responses_count'
      @posts = base_query.order(responses_count: :desc).page(params[:page]).per(5)
    else
      @posts = base_query.order(created_at: :desc).page(params[:page]).per(5)
    end
  end                

  # GET /posts/1 or /posts/1.json
  def show
    @post = Post.find(params[:id])
    @responses = @post.responses
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = current_user.posts.new(post_params)  # この行を変更しました

    respond_to do |format|
      if @post.save
        format.html { redirect_to posts_url }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def notify
    @post = Post.find(params[:id])
    # ここで通知内容を保存します。例えば、新たにNotificationモデルを作成して保存することができます。
    # Notification.create(user: current_user, post: @post, comment: params[:comment])
  
    # メールを送信します
    PostMailer.with(post: @post, comment: params[:comment]).notify_post_admin.deliver_now
  
    redirect_to posts_path, notice: '管理者に通知しました'
  end
  
  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :body)
    end
end
