class PostsController < ApplicationController
	def edit
		@post = Post.find(params[:id])
	end

	def update
		@post = Post.find(params[:id])
		@post.update(post_params)
		@post.save
		redirect_to @post
	end

	def show
		@post = Post.find(params[:id])
    	@user = User.where(id: @post.user_id).first
		## would be in the comments controller if we were seperating it out
		@comments = @post.comments
  	end

	def new
		@post = Post.new
		@user = current_user
	end

	def create
		@post = Post.new(post_params)
		if @post.save
			redirect_to '/'
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
		redirect_to '/'
	end
	
	def time_ago_in_words(from_time)
    	distance_of_time_in_words(from_time, Time.now)
  	end

	private

	def post_params
		params.require(:post).permit(:title, :content, :user_id)
	end

	def comment_params
		params.require(:comment).permit(:comment, :user_id, :post_id)
	end


end
