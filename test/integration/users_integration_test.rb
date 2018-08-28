require 'test_helper'

class UserIntegrationTest < ActionDispatch::IntegrationTest

	def setup 
		@user = User.create(name: 'Test', mail: 'test@gmail.com', contact: '9997775550', user_type: 'Admin', password: 'Password')

	end

	test "get sign up page and register as user" do

		get signup_path
		assert_template 'users/new'

		assert_difference 'User.count', 1 do
			post users_url, params: {user: {name: 'New one', mail: 'new@gmail.com', contact: '8887775550', user_type: 'Admin', password: 'Password'}}
			follow_redirect!
		end

		assert_template 'users/show'
		assert_match 'new@gmail.com', response.body
	end

	test "user login" do

		get login_path
		assert_template 'sessions/new'

		post login_url, params: { session: {mail: @user.mail, password: "Password"}}
		follow_redirect!

		assert_response :success

		assert_template 'users/show'

		assert_match 'test@gmail.com', response.body

	end

	test "user logout" do

		sign_in_as(@user, "Password")

	    delete logout_url(@user)
	    assert_redirected_to root_path
		assert_equal 'You have successfully logged out.... Come back soon!!!!!',flash[:success]

	end

	test "do not access users page without login" do

		get user_path(@user)
		assert_redirected_to login_path

		assert_equal 'Login as Admin to Access user related functionalities', flash[:danger]

	end

end