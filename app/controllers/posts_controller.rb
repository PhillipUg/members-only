class PostsController < ApplicationController
  # before_action :set_post, only: %i[show edit update destroy]
  before_action :authenticate_member!, only: %i[new create]

  # GET /posts
  def index
    @posts = Post.all.order('created_at DESC')
    @post = Post.new
  end

  # GET /posts/new
  def new
    @post = current_member.posts.build
  end

  # POST /posts
  def create
    @post = current_member.posts.build(post_params)

    if @post.save
      redirect_to root_path, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  private

  # # Use callbacks to share common setup or constraints between actions.
  # def set_post
  #   @post = Post.find(params[:id])
  # end

  # Only allow a trusted parameter "white list" through.
  def post_params
    params.require(:post).permit(:body)
  end
end
