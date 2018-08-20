class User < ApplicationRecord

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	#VALID_CONTACT_REGEX =/^(\+\d)*\s*(\(\d{3}\)\s*)*\d{3}(-{0,1}|\s{0,1})\d{2}(-{0,1}|\s{0,1})\d{2}$/
	
	validates :name, presence:true, length:{minimum:4,maximum:25}
	validates :mail, presence:true, uniqueness:{ case_sensitive: false },length:{maximum:100}, format: { with:VALID_EMAIL_REGEX }
	before_save :downcase_fields
	validates :contact, presence:true, uniqueness:true, numericality:true, length: {minimum:10,maximum:10}
	validates :user_type, presence:true

	has_many :transactions
	has_many :houses, through: :transactions

	def downcase_fields
		self.mail.downcase!
	end
end