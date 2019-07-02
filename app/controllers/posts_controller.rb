class PostsController < ApplicationController
  skip_before_action :authenticate_request, only: :index
  before_action :set_context, except: :index

  def index
    render json: Post.all, status: :success
  end

  def create
    @post = PostsService.create_post(@context, post_params)

    if @post.success?
      render json: @post.result, status: :created
    else
      render json: { errors: @post.errors }, status: :unauthorized
    end
  end

  def update
    @post = PostsService.update_post(@context, post_params)

    if @post.success?
      render json: @post.result, status: :updated
    else
      render json: { errors: @post.errors }, status: :unauthorized
    end
  end

  def destroy
    @post = PostsService.destroy_post(@context)

    if @post.success?
      head :no_content
    else
      render json: { errors: @post.errors }, status: :unauthorized
    end
  end

  private

  def set_context
    @context = { current_user: @current_user }
    @context[:post_id] = params[:id] if params[:id]
  end

  def post_params
    params.require(:post).permit(:body, :id)
  end
end
