class HousesController < ApplicationController
	
	def index
		@houses = House.all
	end

	def new 
		@house = House.new
		@users = User.all
	end

	def create
		@house = House.new(house_params)
		if @house.save
			flash[:notice] = "Your House #{@house.name} is successfully listed in our site"
			redirect_to house_path(@house)
		else
			render 'new'
		end
	end

	def show
		@house = House.find(params[:id])
	end

	def edit
		@house = House.find(params[:id])
	end

	def update
		@house = House.find(params[:id])
		if @house.update(house_params)
			flash[:notice] = "Your House #{@house.name} details are successfully updated"
			redirect_to house_path(@house)
		else
			render 'edit'
		end
	end

	def destroy
		@house = House.find(params[:id])
		@house.destroy
		flash[:notice] = "Your House #{@house.name} is successfully removed from listing"
		redirect_to houses_path(@house)
	end

	private
	def house_params
		params.require(:house).permit(:name, :address, :property_for, :furniture, :amount, :age_of_property, :user_id)
	end

end