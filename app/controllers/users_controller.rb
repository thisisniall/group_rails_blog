class UsersController < ApplicationController
  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
  	@user.update(params[:user])
  	@user.save
  	redirect_to @user
  end

  def index
  	@users = User.all
  end

  def new
  	@user=User.new
  end

  def create
  	@user = User.new(params[:user])
  	if @user.save
  		redirect_to user_path @user
  	else
  		redirect_to new_user_path
  	end
  end

  def show
  	@user = User.find(params[:id])
    @post = @user.posts
  end

  def destroy
  	@user = User.find(params[:id])
  	if @user.destroy
  	else
  	end
  	redirect_to users_path
  end

    private

  def user_params
    params.require(:user).permit(:username, :password, :fname, :lname)
  end

end
