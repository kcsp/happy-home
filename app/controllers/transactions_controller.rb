class TransactionsController < ApplicationController

before_action :validate_user, only: [:create]
before_action :validate_admin, only: [:edit, :update]

	def create
		@transaction = Transaction.new
		@house = House.find(params[:format])
		@transaction.user =  current_user
		@transaction.house = @house
		if @transaction.save
			flash[:success] = "Congratulations for your new house #{@house.name}.... We are waiting to welcome you"
			redirect_to transactions_path
		else
			flash[:danger] = "Something went wrong ... Unable to book #{@house.name}.. Pls try again later "
			redirect_to houses_path
		end
	end

	def show
	end

	def index
		@transactions = Transaction.paginate(page: params[:page], per_page: 1)
	end

	def validate_user
	 	if logged_in?
			if current_user.user_type != 'Tenant' && current_user.user_type != 'Admin'
				flash[:danger] = "You are not the Tenant to book the house "
				redirect_to root_path
			end
		else
			flash[:danger] = "Login to perform this operation on houses"
			redirect_to root_path
		end
	end

	def validate_admin

		if logged_in?
			if current_user.user_type != 'Admin'
				flash[:danger] = "You are not the Admin to perform this operation "
				redirect_to root_path
			end
		else
			flash[:danger] = "Login to perform this operation on houses"
			redirect_to root_path
		end

	end

end