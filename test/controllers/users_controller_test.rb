require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

	def setup

		@user = User.create(name: 'Test', mail: 'test@gmail.com', contact: '9997775550', user_type: 'Admin', password: 'Password')

	end

	test "create user" do

		assert_difference('User.count') do
			post users_url, params: { user: {name: 'New one', mail: 'new@gmail.com', contact: '8887775550', user_type: 'Admin', password: 'Password'}}
		end

		assert_redirected_to user_path(User.last.id)
		assert_equal "User was successfully created",flash[:success]

	end

	test "should get user index" do

		sign_in_as(@user,"Password")
		get users_path
		assert_response :success

	end

	test "should get new" do

		get login_path
		assert_response :success

	end

	test "should get show" do

		sign_in_as(@user,"Password")
		get user_path(@user)
		assert_response :success

	end

	test "should get edit path" do

		sign_in_as(@user,"Password")
		get edit_user_path(@user)
		assert_response :success

	end

	test "should update user details" do

		sign_in_as(@user,"Password")
		@user.mail = "new@gmail.com"

		patch user_url(@user),params: { user: {name: 'Test', mail: 'new@gmail.com', contact: '9997775550', user_type: 'Admin', password: 'Password'}} 
		assert_redirected_to user_path(@user)

		@user.reload

		assert_equal "new@gmail.com", @user.mail

	end

	test "should destroy account" do

		sign_in_as(@user,"Password")

		assert_difference('User.count',-1) do
			delete user_url(@user)
		end

		assert_redirected_to root_path
		
	end


end