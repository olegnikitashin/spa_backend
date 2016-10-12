module Api
  class PostsController < ApplicationController
    before_action :find_post, only: [:show, :update, :destroy]

    def index
      @posts = Post.order(created_at: :desc)
      render json: @posts, status: 200
    end

    def show
      render json: @post, status: 200
    end

    def create
      @post = Post.new(post_params)

      if @post.save
        render json: @post, status: 201, location: [:api, @post]
      else
        render json: { errors: post.errors }, status: 422
      end
    end

    def update
      if @post.update(post_params)
        render json: @post, status: 200, location: [:api, @post]
      else
        render json: { errors: @post.errors }, status: 422
      end
    end

    def destroy
      @post.destroy
      head 204
    end

    private

    def post_params
      params.require(:post).permit(:title, :body, :username)
    end

    def find_post
      @post = Post.find(params[:id])
    end
  end
end
