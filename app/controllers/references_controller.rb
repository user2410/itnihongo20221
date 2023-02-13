class ReferencesController < ApplicationController
  before_action :set_post, only: [:index, :create]
  before_action :set_reference, only: [:show, :update, :destroy]

  # GET /posts/:post_id/references
  def index
    @references = @post.references
    render json: @references
  end

  # GET /references/1
  def show
    render json: @reference
  end

  # POST /posts/:post_id/references
  def create
    @post = Post.find_by(id: params[:post_id])
    if @post.nil?
      render json: { error: 'Post not found' }, status: :not_found
      return
    end
  
    @reference = @post.references.new(reference_params)
  
    if @reference.save
      render json: @reference, status: :created
    else
      render json: @reference.errors, status: :unprocessable_entity
    end
  end
  

  # PATCH/PUT /references/1
  def update
    if @reference.update(params[:reference][:link])
      render json: @reference
    else
      render json: @reference.errors, status: :unprocessable_entity
    end
  end

  # DELETE /references/1
  def destroy
    @reference.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      puts "params[:post_id]: #{params[:post_id]}"
      @post = Post.find(params[:post_id])
    end

    def set_reference
      @reference = Reference.find(params[:id])
    end

    def reference_params
      params.require(:reference).permit(:link, :post_id)
    end
end
