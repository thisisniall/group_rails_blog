class Relationship < ActiveRecord::Base
	belongs_to :followed, class_name: 'User'
	belongs_to :follower, class_name: 'User'

	#BRADLEY
	validates_uniqueness_of :follower_id, scope: :followed_id

	validates_uniqueness_of :followed_id, scope: :follower_id
end
