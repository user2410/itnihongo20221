class PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :destroy]

  # GET /posts
  def index
    @posts = Post.all

    render json: @posts, include: [:topics]
  end

  # GET /posts/1
  def show
    render json: @post, include: [:topics]
  end

  # POST /posts
  def create
    authenticate_account!
    @post = Post.new(post_params)
    @post[:user_id] = current_account.id

    if @post.save
      render json: @post, status: :created, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    authenticate_account!
    if current_account.id != @post[:user_id].to_i
      render json: { message: 'Not your post' }, status: :forbidden
      return
    end

    @post[:user_id] = current_account.id

    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PUT /posts?post_id=1&topic_id=1
  def assign_to_topic
    authenticate_account!
    queries = request.query_parameters
    post_id = queries[:post_id]
    topic_id = queries[:topic_id]
    # puts topic_id, post_id

    post = Post.find(post_id)
    topic = Topic.find(topic_id)
    post.topics << topic
  end

  # DELETE /posts/1
  def destroy
    authenticate_account!
    puts current_account.role
    if (current_account.id != @post[:user_id].to_i) && current_account.user?
      render json: { message: 'Not your post' }, status: :forbidden
      return
    end
    @post.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.includes(:topics).find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def post_params
      params.require(:post).permit(:user_id, :term, :description, :post_id)
    end
end