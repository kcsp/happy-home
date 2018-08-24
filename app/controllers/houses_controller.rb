class HousesController < ApplicationController

	before_action :set_house, only: [:edit, :update, :show, :destroy]

	before_action :require_user, except: [:index, :show]

	before_action :validate_user, only: [:edit, :update, :destroy]
	
	def index
		@houses = House.paginate(page: params[:page], per_page: 1)
	end

	def new 
		@house = House.new
		@users = User.all
	end

	def create
		@house = House.new(house_params)
		@house.user = current_user
		if @house.save
			flash[:success] = "Your House #{@house.name} is successfully listed in our site"
			redirect_to house_path(@house)
		else
			render 'new'
		end
	end

	def show
	end

	def edit
	end

	def update
		if @house.update(house_params)
			flash[:success] = "Your House #{@house.name} details are successfully updated"
			redirect_to house_path(@house)
		else
			render 'edit'
		end
	end

	def destroy
		@house.destroy
		flash[:danger] = "Your House #{@house.name} is successfully removed from listing"
		redirect_to houses_path(@house)
	end

	private
	def house_params
		params.require(:house).permit(:name, :address, :property_for, :furniture, :bhk, :amount, :age_of_property)
	end

	def set_house
		@house = House.find(params[:id])
	end 

	 def validate_user
		if current_user != @house.user && current_user.user_type != 'Admin'
			flash[:danger] = "You are not the owner of this house to perform operations"
			redirect_to root_path
		end
	end

end