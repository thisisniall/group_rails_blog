class UsersController < ApplicationController
  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
  	@user.update(user_params)
  	@user.save
  	redirect_to @user
  end

  def index
  	@users = User.all
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      current_user = @user
      session[:user_id] = @user.id
  		redirect_to '/'
  	else
      flash[:notice] = "There was a problem creating your account, please try again."
  		redirect_to new_user_path
  	end
  end

  def show
  	@user = User.find(params[:id])
    @post = @user.posts
    @relationship = Relationship.new
  end

  def verify_user
    @user = User.find(params[:id])
    if @user.password == params[:password1] && params[:password1] == params[:password2]
      destroy
    else
      flash[:alert] = "Passwords don't match or password entered doesn't match our records"
      redirect_to edit_user_path
    end
  end

  def destroy
  	@user = User.find(params[:id])
    @user.destroy
    session[:user_id] = nil
    current_user = nil
    flash[:notice] = "Account Deleted"
    redirect_to '/'
  end

    private

  def user_params
    params.require(:user).permit(:username, :password, :fname, :lname, :avatar)
  end

end
