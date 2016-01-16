class User < ActiveRecord::Base
	# so the user can see a preview of the image they're uploading 
	attr_accessor :avatar_cache

	has_many :posts, dependent: :destroy
	has_many :comments, dependent: :destroy

	# thank you carrierwave documentation for your kind words and encouragement
	mount_uploader :avatar, AvatarUploader

	# below join table work uses http://nycda.com/blog/followings-in-sinatra/ HEAVILY as reference - of course we're attempting to use it rails rather than sinatra

	# first establish a relationship to the join table, then establish the relationship to the table being joined to in the second line of code. 

	# Normally, when declaring a relationship to a join table, the foreign key is inferred using the name of the model itself. In this case, since the follower_id is not just a user_id, we need to be explicit.
	has_many :relationships, foreign_key: :follower_id
	has_many :followed, through: :relationships, source: :followed
	#
	has_many :reverse_relationships, foreign_key: :followed_id, class_name: 'Relationship'
	has_many :followers, through: :reverse_relationships, source: :follower

	validates_presence_of :username
	validates_presence_of :password
	validates :username, uniqueness: true
end
