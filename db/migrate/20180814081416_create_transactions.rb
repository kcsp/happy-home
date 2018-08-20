class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
    	t.string :name
    	t.string :mail
    	t.integer :contact
    	t.string :user_type
    	t.timestamps
    end

    create_table :houses do |t|
    	t.string :name
    	t.text :address
    	t.string :property_for
    	t.string :furniture
    	t.bigint :amount
    	t.integer :age_of_property
    	t.belongs_to :user, index: true
    	t.timestamps
    end

    create_table :transactions do |t|
    	t.belongs_to :user, index: true
    	t.belongs_to :house, index: true
    	t.timestamps
    end
  end
end
