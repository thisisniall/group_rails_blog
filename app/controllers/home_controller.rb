class HomeController < ApplicationController
	def index
		if !current_user
			redirect_to '/log-in'
		else
			@posts = Post.all
			@post = Post.new
			@user = current_user
		end
	end
end
