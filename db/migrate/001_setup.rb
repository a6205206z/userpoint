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
			t.column :login_name, :string, :limit => 30, :default => "", :null => false, :unique => true
			t.column :login_password, :string, :default => "", :null =>false
			t.column :real_name, :string, :default => "", :null => false
			t.column :sex, :integer, :limit => 2, :default => 0, :null => false
			t.column :create_time, :datetime, :null => false
			t.column :user_point, :integer, :default => 0, :null => false
			t.column :user_money, :decimal, :default => 0.0, :null => false, precision: 12, scale: 2
			t.column :profile, :string, :default => "", :null => false
			t.column :persistence_token, :string, :null => false

		end

		create_table :user_addresses do |t|
			t.column :user_id, :integer, :defualt => 0, :null => false
			t.column :real_name, :string, :default => "", :null => false
			t.column :mobile, :string, :default => "", :null => false
			t.column :country, :string, :defualt => "", :null => false
			t.column :province, :string, :defualt => "", :null => false
			t.column :city, :string, :defualt => "", :null => false
			t.column :area, :string, :defualt => "", :null => false
			t.column :post_code, :string, :defualt => "", :null => false
			t.column :address, :string, :defualt => "", :null => false
		end

		create_table :user_point_ios do |t|
			t.column :user_id, :integer, :defualt => 0, :null => false
			t.column :point, :integer, :default => 0, :null =>false
			t.column :remarks, :string, :limit => 125, :defualt => "", :null => false
			t.column :status, :integer, :default => 0, :null => false
			t.column :operate_time, :datetime, :null => false
			t.column :from, :string, :default => "", :null => false
			t.column :code, :string, :default => "", :null =>false
		end

		create_table :code_sources do |t|
			t.column :user_id, :integer, :defualt => 0, :null => false, :unique => true
			t.column :code, :string, :default => 0, :null => false, :unique => true
			t.column :add_point, :integer, :default =>0, :null => false
			t.column :add_money, :decimal, :default => 0.0, :null => false, precision: 12, scale: 2
			t.column :from_agency_id, :integer, :defualt => 0, :null => false 
			t.column :remarks, :string, :limit => 200
			t.column :create_time, :datetime, :null => false
			t.column :expire_time, :datetime, :null => false
		end

		create_table :agencies do |t|
			t.column :login_name, :string, :limit => 30, :default => "", :null => false, :unique => true
			t.column :login_password, :string, :default => "", :null =>false
			t.column :name, :string, :default => "", :null => false
			t.column :address, :string, :default => "", :null => false
			t.column :contact, :string, :default => "", :null => false
			t.column :phone, :string, :default => "", :null => false
			t.column :profile, :string, :default => "", :null => false
			t.column :persistence_token, :string, :null => false
		end

		create_table :buy_car_requests do |t|
			t.column :user_id, :integer, :defualt => 0, :null => false
			t.column :user_id_number, :string, :default => "", :null => false
			t.column :agency_id, :integer, :defualt => 0, :null => false 
			t.column :req_info, :string, :default => "", :null => false
			t.column :money_io_ids, :string, :default => "", :null => false
			t.column :create_time, :datetime, :null => false
			t.column :status, :integer, :default => 0, :null => false
		end



		create_table :user_money_ios do |t|
			t.column :user_id, :integer, :defualt => 0, :null => false
			t.column :money, :decimal, :defualt => 0.00, :null => false, precision: 12, scale: 2
			t.column :remarks, :string, :limit => 125, :defualt => "", :null => false
			t.column :status, :integer, :default => 0, :null => false
			t.column :operate_time, :datetime, :null => false
			t.column :code, :string, :default => "", :null =>false
			t.column :from_agency_id, :integer, :defualt => 0, :null => false 
		end

		create_table :products do |t|
			t.column :name, :string, :null => false 
			t.column :sales_point, :integer, :defualt => 0, :null => false
			t.column :original_point, :integer, :default => 0, :null => false
			t.column :product_img_url, :string, :limit => 60, :default => "", :null => false
			t.column :inventory, :integer, :default => 0, :null => false
			t.column :description, :string
			t.column :create_time, :datetime, :null => false
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
			t.column :area, :string, :defualt => "", :null => false
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




		agency =  Agency.new :login_name => "dongfeng",
							 :login_password => UserInfo.hash_password("dongfeng"),
						     :name => "东风标致",
							 :address => "四川省 成都市 锦江区 中环广场35层",
							 :contact => "李先生",
							 :phone => "13545678954",
							 :profile => "profile/man.png",
							 :persistence_token => ""
		agency.save


		product = Product.new :name => "商品",
							  :sales_point => 20,
							  :original_point => 30,
							  :product_img_url => "product/default.png",
							  :inventory => 100,
							  :description => "系统初始化商品",
							  :create_time => Time.new

		product.save

		#for i in 0..5
		#	product = Product.new(product)
		#	product.name = "商品" << i
		#	product.save
		#end


		product_1 = Product.new :name => "商品1",
							  :sales_point => 20,
							  :original_point => 30,
							  :product_img_url => "product/default.png",
							  :inventory => 100,
							  :description => "系统初始化商品",
							  :create_time => Time.new

		product_1.save


		product_2 = Product.new :name => "商品2",
							  :sales_point => 20,
							  :original_point => 30,
							  :product_img_url => "product/default.png",
							  :inventory => 100,
							  :description => "系统初始化商品",
							  :create_time => Time.new

		product_2.save


		product_3 = Product.new :name => "商品3",
							  :sales_point => 20,
							  :original_point => 30,
							  :product_img_url => "product/default.png",
							  :inventory => 100,
							  :description => "系统初始化商品",
							  :create_time => Time.new

		product_3.save


		product_4 = Product.new :name => "商品4",
							  :sales_point => 20,
							  :original_point => 30,
							  :product_img_url => "product/default.png",
							  :inventory => 100,
							  :description => "系统初始化商品",
							  :create_time => Time.new

		product_4.save
	end

	def self.down
		drop_table :user_infos
		drop_table :user_addresses
		drop_table :user_point_ios
		drop_table :code_sources
		drop_table :agencies
		drop_table :buy_car_requests
		drop_table :user_money_ios
		drop_table :products
		drop_table :orders
		drop_table :order_shippings
		drop_table :order_items
	end
end
