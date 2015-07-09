# User Point project
#
#file: setup.rb
#description: setup the system data base



class Setup < ActiveRecord::Migration
	def self.up
		create_table :userinfo do |t|
			t.column :user_id, :string, null => false
			t.column :login_name, :string, :limit => 30, :default => "", :null => false
			t.column :login_password, :string, :default => "", :null =>false
			t.column :real_name, :string, :default => "", :null => false
			t.column :age, :integer, :default => 0,  :null => false
			t.column :sex, :integer, :limit => 2, :default => 0, :null => false
			t.column :create_time, :datetime, :null => false
			t.column :user_point, :integer, :default => 0, :null => false
			t.column :user_money, :decimal, :default => 0.0 :null => false
		end

		create_table :user_address do |t|
			t.column :user_id, :string, :defualt => "", :null => false
			t.column :country, :string, :defualt => "", :null => false
			t.column :province, :string, :defualt => "", :null => false
			t.column :city, :string, :defualt => "", :null => false
			t.column :post_code, :string, :defualt => "", :null => false
			t.column :address, :string, :defualt => "", :null => false
		end

		create_table :user_point_io do |t|
			t.column :user_id, :string, :defualt => "", :null => false
			t.column :point, :integer, :default => 0, :null =>false
			t.column :remarks, :string, :limit => 125, :defualt => "", :null => false
			t.column :status, :integer, :default => 0, :null => false
			t.column :operate_time, :datetime, :null => false
			t.column :operate_user_id,  :string, :default => "system", :null => false
			end
		end

		create_table :user_money_io do |t|
			t.column :user_id, :string, :defualt => "", :null => false
			t.column :money, :decimal, :defualt => 0.0, :null => false, scale: 2
			t.column :remarks, :string, :limit => 125, :defualt => "", :null => false
			t.column :status, :integer, :default => 0, :null => false
			t.column :operate_time, :datetime, :null => false
			t.column :operate_user_id, :string, :default => "system", :null => false
		end

		create_table :prdocut do |t|
			t.column :product_id, :string, :defualt => "", :null => false
			t.column :sales_point, :integer, :defualt => 0， :null => false
			t.column :original_point, :integer, :default => 0, :null => false
			t.column :product_img_url, :string, :limit => 60, :default => "", :null => false
			t.column :inventory, :integer, :default => 0, :null => false
			t.column :description, :string
		end

		create_table :order do |t|
			t.column :order_id， :string, :default => "", :null => false
			t.column :order_point, :integer, :default => 0, :null => false
			t.column :status, :integer, :default => 0, :null => false
			t.column :create_time, :datetime, :null => false
			
		end
	end

	def self.down
		drop_table :userinfo
		drop_table :user_address
		drop_table :user_point
		drop_table :user_money_io
		drop_table :prdocut
	end
end