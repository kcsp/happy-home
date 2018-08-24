class UsersController < ApplicationController

	before_action :set_user, only: [:edit, :update, :show, :destroy]

	before_action :validate_user, only: [:index, :show, :edit, :update, :destroy]
	
	def index
		@users = User.paginate(page: params[:page], per_page: 2)
	end

	def new 
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			flash[:success] = "User was successfully created"
			redirect_to user_path(@user)
		else
			render 'new'
		end
	end

	def show
		@user_houses = @user.houses.paginate(page: params[:page], per_page: 1)
	end

	def edit
	end

	def update
		if @user.update(user_params)
			flash[:success] = "User details are successfully updated"
			redirect_to user_path(@user)
		else
			render 'edit'
		end
	end

	def destroy
		@user.destroy
		session[:user_id] = nil
		flash[:danger] = "User account is successfully deleted"
		redirect_to root_path
	end

	private
	def user_params
		params.require(:user).permit(:name, :mail, :contact, :user_type, :password)
	end

	def set_user
		@user = User.find(params[:id])
	end 

	def validate_user
		if current_user != @user && current_user.user_type != 'Admin' 
			flash[:danger] = "You can view or perform action to your own account"
			redirect_to root_path
		end
	end

end