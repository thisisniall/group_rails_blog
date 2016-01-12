class HomeController < ApplicationController
	def index
		if current_user
			@posts = Post.all
			@post = Post.new
			@user = current_user
		else
			redirect_to '/log-in'
		end
	end
end
