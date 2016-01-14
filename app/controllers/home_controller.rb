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

	# defines a function that prints the difference of two times as words to your page
	# you pass the function the time that you want begin at it finds the difference of
	# that and the current time when the function is called
	def time_ago_in_words(from_time)
		distance_of_time_in_words(from_time, Time.now)
	end
end
