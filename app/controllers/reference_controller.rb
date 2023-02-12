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
    @reference = @post.references.new(reference_params)

    if @reference.save
      render json: @reference, status: :created, location: @reference
    else
      render json: @reference.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /references/1
  def update
    if @reference.update(reference_params)
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
      @post = Post.find(params[:post_id])
    end

    def set_reference
      @reference = Reference.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def reference_params
      params.require(:reference).permit(:link)
    end
end
