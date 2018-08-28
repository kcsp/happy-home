require 'test_helper'

class UserTest < ActiveSupport::TestCase

	def setup
		@user = User.new(name: 'Test', mail: 'test@gmail.com', contact: '9997775550', user_type: 'Admin', password: 'Password')
	end

	test "validation for creation of user" do 

		assert @user.valid?
		
	end

	test "name should contain atleast 4 chars" do

		@user.name = 'tes'
		assert_not @user.valid?

	end

	test "name should be present" do

		@user.name = ''
		assert_not @user.valid?

	end

	test "mail should be valid" do

		@user.mail = 'testAgmail.com'
		assert_not @user.valid?

	end

	test "invalid contact number" do

		@user.contact = '999777'
		assert_not @user.valid?

	end

	test "invalid contact number value" do

		@user.contact = 'invalid value'
		assert_not @user.valid?

	end	

	test "user_type should be present" do

		@user.user_type = nil
		assert_not @user.valid?

	end

	test "password should not be empty" do

		@user.password = nil
		assert_not @user.valid?

	end

	test "password should have atleast 8 chars" do

		@user.password = "nil"
		assert_not @user.valid?
		
	end

	test "should not create user with same mail" do

		assert @user.save!
		existing_user = User.new(name: 'TestNew', mail: 'test@gmail.com', contact: '8887775550', user_type: 'Admin', password: 'Password')
		assert_not existing_user.valid?

	end

end