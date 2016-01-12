class PostsController < ApplicationController
	def edit
		@post = Post.find(params[:id])
	end

	def update
		@post = Post.find(params[:id])
		@post.update(params[:post])
		@post.save
		redirect_to @post
	end

	def show
		@post = Post.find(params[:id])
  	end

	def new
		@post = Post.new
		@user = current_user
	end

	def create
		@post = Post.new(params[:post])
		if @post.save
			redirect_to posts_path
		else
			redirect_to new_post_path
		end
	end

	def index
		@posts = Post.all
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy
		redirect_to posts_path
	end

	private

	def post_params
		params.require(:post).permit(:title, :content, :user_id)
	end
end
