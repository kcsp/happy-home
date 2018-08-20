class House < ApplicationRecord

	validates :name, presence:true, length:{minimum:4,maximum:25}
	validates :address, presence:true, length:{minimum:10,maximum:250}
	validates :user_id, presence:true
	validates :furniture, presence:true
	validates :amount, presence:true, numericality: true
	validates :age_of_property, presence:true, numericality: true

	belongs_to :user
	has_many :transactions
	has_many :users, through: :transactions

end