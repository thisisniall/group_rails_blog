class CommentsController < ApplicationController
	
	def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.create(comment_params)
		redirect_to post_path(@post)
	end

	def time_ago_in_words(from_time)
   		distance_of_time_in_words(from_time, Time.now)
 	end

	private

	def comment_params
		params.require(:comment).permit(:comment, :user_id, :post_id)
	end
end
