class RelationshipsController < ApplicationController
	def create
		@relationship = Relationship.new(follower_id: current_user.id, followed_id: params[:id])
		@relationship.save
		redirect_to :back
	end

	def destroy
		@relationshipend = Relationship.find_by(follower_id: current_user.id, followed_id: params[:id])
		@relationshipend.destroy
		redirect_to :back
	end

	private

	def relationship_params
		params.require(:relationship).permit(:follower_id, :followed_id)
	end

end
