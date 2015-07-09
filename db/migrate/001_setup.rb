# User Point project
#
#file: setup.rb
#author: cean cheng
#email: cean.ch@gmail.com
#description: setup the system data base
#


class Setup < ActiveRecord::Migration
	def self.up
		create_table :user_infos do |t|
			t.column :login_name, :string, :limit => 30, :default => "", :null => false
			t.column :login_password, :string, :default => "", :null =>false
			t.column :real_name, :string, :default => "", :null => false
			t.column :age, :integer, :default => 0,  :null => false
			t.column :sex, :integer, :limit => 2, :default => 0, :null => false
			t.column :create_time, :datetime, :null => false
			t.column :user_point, :integer, :default => 0, :null => false
			t.column :user_money, :decimal, :default => 0.0, :null => false, precision: 5, scale: 2
		end

		create_table :user_addresses do |t|
			t.column :user_id, :integer, :defualt => 0, :null => false
			t.column :real_name, :string, :default => "", :null => false
			t.column :mobile, :string, :default => "", :null => false
			t.column :country, :string, :defualt => "", :null => false
			t.column :province, :string, :defualt => "", :null => false
			t.column :city, :string, :defualt => "", :null => false
			t.column :post_code, :string, :defualt => "", :null => false
			t.column :address, :string, :defualt => "", :null => false
		end

		create_table :user_point_ios do |t|
			t.column :user_id, :integer, :defualt => 0, :null => false
			t.column :point, :integer, :default => 0, :null =>false
			t.column :remarks, :string, :limit => 125, :defualt => "", :null => false
			t.column :status, :integer, :default => 0, :null => false
			t.column :operate_time, :datetime, :null => false
			t.column :operate_user_id,  :integer, :default => 0, :null => false
		end

		create_table :user_money_ios do |t|
			t.column :user_id, :integer, :defualt => 0, :null => false
			t.column :money, :decimal, :defualt => 0.00, :null => false, precision: 5, scale: 2
			t.column :remarks, :string, :limit => 125, :defualt => "", :null => false
			t.column :status, :integer, :default => 0, :null => false
			t.column :operate_time, :datetime, :null => false
			t.column :operate_user_id, :integer, :default => 0, :null => false
		end

		create_table :prdocuts do |t|
			t.column :sales_point, :integer, :defualt => 0, :null => false
			t.column :original_point, :integer, :default => 0, :null => false
			t.column :product_img_url, :string, :limit => 60, :default => "", :null => false
			t.column :inventory, :integer, :default => 0, :null => false
			t.column :description, :string
		end

		create_table :orders do |t|
			t.column :user_id, :integer, :default => 0, :null => false
			t.column :order_point, :integer, :default => 0, :null => false
			t.column :status, :integer, :default => 0, :null => false
			t.column :create_time, :datetime, :null => false
			t.column :remarks, :string, :limit => 200
		end

		create_table :order_shippings do |t|
			t.column :order_id, :integer, :default => 0, :null => false
			t.column :real_name, :string, :default => "", :null => false
			t.column :mobile, :string, :default => "", :null => false
			t.column :country, :string, :defualt => "", :null => false
			t.column :province, :string, :defualt => "", :null => false
			t.column :city, :string, :defualt => "", :null => false
			t.column :post_code, :string, :defualt => "", :null => false
			t.column :address, :string, :defualt => "", :null => false
		end

		create_table :order_items do |t|
			t.column :order_id, :integer, :default => 0, :null => false
			t.column :product_id, :integer, :default => 0, :null => false
			t.column :pre_point, :integer, :default => 0, :null => false
			t.column :count, :integer, :default => 0, :null => false
			t.column :total_point, :integer, :default => 0, :null => false
		end
	end

	def self.down
		drop_table :user_infos
		drop_table :user_addresses
		drop_table :user_point_ios
		drop_table :user_money_ios
		drop_table :prdocuts
		drop_table :orders
		drop_table :order_shippings
		drop_table :order_items
	end
end
