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
			t.column :code, :string, :default => 0, :null => false
			t.column :add_point, :integer, :default =>0, :null => false
			t.column :add_money, :decimal, :default => 0.0, :null => false, precision: 12, scale: 2
			t.column :remarks, :string, :limit => 200
			t.column :create_time, :datetime, :null => false
			t.column :expire_time, :datetime, :null => false
		end

		create_table :user_money_ios do |t|
			t.column :user_id, :integer, :defualt => 0, :null => false
			t.column :money, :decimal, :defualt => 0.00, :null => false, precision: 12, scale: 2
			t.column :remarks, :string, :limit => 125, :defualt => "", :null => false
			t.column :status, :integer, :default => 0, :null => false
			t.column :operate_time, :datetime, :null => false
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

		#create sa user
		user = UserInfo.new :login_name => "sa",
							:real_name => "系统管理员",
							:sex => 1,
							:create_time => Time.new,
							:user_point => 99999,
							:user_money => 99999.99

		user.persistence_token = ""

		#password:Admin$11 sha1编码
		user.login_password = "71f442930e425a18bca792c0b4aa19ca84ca324d"
		user.profile = "profile/" << "man" << ".png"
		user.save

		

		my_code = CodeSource.new :user_id => user.id,
							  :code => "000000",
							  :add_point => 99999,
							  :add_money => 99999.99,
							  :remarks => "System init",
							  :create_time => Time.new,
							  :expire_time => Time.new

		my_code.save


		#init point io
		point_io = UserPointIO.new :user_id => user.id,
								   :point => 99999,
								   :remarks => "系统初始化",
								   :status => 1,
								   :operate_time => Time.new,
								   :from => "System",
								   :code => "000000"

		point_io.save

		#init money io
		money_io = UserMoneyIO.new :user_id => user.id,
								   :money => 99999.99,
								   :remarks => "系统初始化",
								   :status => 1,
								   :operate_time => Time.new

		money_io.save
	end

	def self.down
		drop_table :user_infos
		drop_table :user_addresses
		drop_table :user_point_ios
		drop_table :code_sources
		drop_table :user_money_ios
		drop_table :prdocuts
		drop_table :orders
		drop_table :order_shippings
		drop_table :order_items
	end
end
