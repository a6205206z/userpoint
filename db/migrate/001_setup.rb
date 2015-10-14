# User Point project
#
#file: setup.rb
#author: cean cheng
#email: cean.ch@gmail.com
#description: setup the system data base
#


class Setup < ActiveRecord::Migration
	def self.up
		create_table :admins do |t|
			t.column :login_name, :string, :limit => 30, :default => "", :null => false, :unique => true
			t.column :login_password, :string, :default => "", :null =>false
			t.column :persistence_token, :string, :null => false
		end

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
			t.column :user_name, :string, :default => "", :null => false
			t.column :phonenumber, :string, :default => "", :null => false
			t.column :invoice_url, :string, :default => "", :null => false
			t.column :money_io_id, :integer, :default => 0, :null => false
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
			t.column :status, :integer, :default => 0, :null => false
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

		create_table :car_owners do |t|
			t.column :user_id, :integer, :default => 0, :null => false, :unique => true
			t.column :agency_id, :integer, :defualt => 0, :null => false
			t.column :car_number, :string, :defualt => "", :null => false
			t.column :invoice_url, :string, :default => "", :null => false
			t.column :car_brand, :string, :default => "", :null => false
			t.column :car_model, :string, :default => "", :null => false
			t.column :car_type, :string, :default => "", :null => false
			t.column :status, :integer, :defualt => 0, :null => false
			t.column :create_time, :datetime, :null => false
		end




		admin =  Admin.new :login_name => "admin",
						   :login_password => UserInfo.hash_password("Admin$11"),
						   :persistence_token => ""
		admin.save

		agency_1 = Agency.new :login_name => "agency_1",
								   :login_password => UserInfo.hash_password("agency_1"),
								   :name => "成都精典东越汽车销售有限公司",
								   :address => "成都市青羊区腾飞大道308号（成飞大道旁）",
								   :contact => "公司",
								   :phone => "4008302434",
								   :profile => "profile/peugeot.jpg",
								   :persistence_token => ""
		agency_1.save

		agency_2 = Agency.new :login_name => "agency_2",
								   :login_password => UserInfo.hash_password("agency_2"),
								   :name => "成都申蓉泓翰汽车销售服务有限公司",
								   :address => "成都市武侯区武兴路110号（三环武侯立交出城往双流方向1.5公里右侧）",
								   :contact => "公司",
								   :phone => "4008302426",
								   :profile => "profile/peugeot.jpg",
								   :persistence_token => ""
		agency_2.save

		agency_3 = Agency.new :login_name => "agency_3",
								   :login_password => UserInfo.hash_password("agency_3"),
								   :name => "成都申蓉泓锦汽车销售服务有限公司",
								   :address => "成都市北新干道申蓉汽车城（海宁皮革城旁）",
								   :contact => "公司",
								   :phone => "4008307041",
								   :profile => "profile/peugeot.jpg",
								   :persistence_token => ""
		agency_3.save

		agency_4 = Agency.new :login_name => "agency_4",
								   :login_password => UserInfo.hash_password("agency_4"),
								   :name => "四川安捷汽车技术服务有限公司",
								   :address => "成都市羊西线国际汽车品牌园（金牛区土龙路1号）",
								   :contact => "公司",
								   :phone => "4008302488",
								   :profile => "profile/peugeot.jpg",
								   :persistence_token => ""
		agency_4.save

		agency_5 = Agency.new :login_name => "agency_5",
								   :login_password => UserInfo.hash_password("agency_5"),
								   :name => "四川明嘉汽车贸易服务有限公司",
								   :address => "成都市东三环二段龙潭工业园成致路30号",
								   :contact => "公司",
								   :phone => "4008302529",
								   :profile => "profile/peugeot.jpg",
								   :persistence_token => ""
		agency_5.save


		agency_6 = Agency.new :login_name => "agency_6",
								   :login_password => UserInfo.hash_password("agency_6"),
								   :name => "成都集大成汽车销售服务有限公司",
								   :address => "四川省成都市高新区火车南站西路1279号（机场路辅道回城方向）",
								   :contact => "公司",
								   :phone => "4008302427",
								   :profile => "profile/peugeot.jpg",
								   :persistence_token => ""
		agency_6.save

		agency_7 = Agency.new :login_name => "agency_7",
								   :login_password => UserInfo.hash_password("agency_7"),
								   :name => "成都天致汽车销售服务有限公司",
								   :address => "四川省成都市锦江区三圣乡幸福梅林（金港赛道斜对面）",
								   :contact => "公司",
								   :phone => "4008304929",
								   :profile => "profile/peugeot.jpg",
								   :persistence_token => ""
		agency_7.save


		agency_8 = Agency.new :login_name => "agency_8",
								   :login_password => UserInfo.hash_password("agency_8"),
								   :name => "四川安捷致信汽车销售服务有限公司",
								   :address => "都江堰市蒲阳大道上阳街496号",
								   :contact => "公司",
								   :phone => "4008724197",
								   :profile => "profile/peugeot.jpg",
								   :persistence_token => ""
		agency_8.save

		agency_9 = Agency.new :login_name => "agency_9",
								   :login_password => UserInfo.hash_password("agency_9"),
								   :name => "成都中鑫海汽车服务有限公司",
								   :address => "四川省崇州市崇阳镇金盆地大道229号",
								   :contact => "公司",
								   :phone => "4008303491",
								   :profile => "profile/peugeot.jpg",
								   :persistence_token => ""
		agency_9.save

		agency_10 = Agency.new :login_name => "agency_10",
								   :login_password => UserInfo.hash_password("agency_10"),
								   :name => "彭州明澈车业有限公司",
								   :address => "彭州市牡丹大道77号",
								   :contact => "公司",
								   :phone => "028-83704333",
								   :profile => "profile/peugeot.jpg",
								   :persistence_token => ""
		agency_10.save

		agency_11 = Agency.new :login_name => "agency_11",
								   :login_password => UserInfo.hash_password("agency_11"),
								   :name => "新津弘致汽车销售服务有限公司",
								   :address => "四川省成都市新津县花桥镇蔡湾村三组",
								   :contact => "公司",
								   :phone => "4008304699",
								   :profile => "profile/peugeot.jpg",
								   :persistence_token => ""
		agency_11.save



		product_01 = Product.new :name => "100元购车抵用券",
							  :sales_point => 100,
							  :original_point => 100,
							  :product_img_url => "product/01.png",
							  :inventory => 100,
							  :description => "购车券使用说明：<br />1、购车抵用券每次只能使用一张，不可叠加使用。可在东风标致成都区域各网点使用。<br />2、购车券不折现，不找零。只可用于购车整车使用，不得用于购买其他附件产品。<br />3、东风标致成都区域保留对本券使用方式最终解释权。",
							  :create_time => Time.new

		product_01.save

		product_001 = Product.new :name => "100元保养抵用券",
							  :sales_point => 100,
							  :original_point => 100,
							  :product_img_url => "product/001.png",
							  :inventory => 100,
							  :description => "保养券使用说明：<br />1、保养券需在所购车网点使用，且保养车型须为东风标致车型。<br/>2、每次保养只能使用一张，该券不可兑换为现金使用，且不找零。<br/>3、东风标致成都区域保留对本券使用方式最终解释权。",
							  :create_time => Time.new

		product_001.save

		product_02 = Product.new :name => "200元购车抵用券",
							  :sales_point => 200,
							  :original_point => 200,
							  :product_img_url => "product/02.png",
							  :inventory => 100,
							  :description => "购车券使用说明：<br />1、购车抵用券每次只能使用一张，不可叠加使用。可在东风标致成都区域各网点使用。<br />2、购车券不折现，不找零。只可用于购车整车使用，不得用于购买其他附件产品。<br />3、东风标致成都区域保留对本券使用方式最终解释权。",
							  :create_time => Time.new

		product_02.save

		product_002 = Product.new :name => "200元保养抵用券",
							  :sales_point => 200,
							  :original_point => 200,
							  :product_img_url => "product/002.png",
							  :inventory => 100,
							  :description => "保养券使用说明：<br />1、保养券需在所购车网点使用，且保养车型须为东风标致车型。<br/>2、每次保养只能使用一张，该券不可兑换为现金使用，且不找零。<br/>3、东风标致成都区域保留对本券使用方式最终解释权。",
							  :create_time => Time.new

		product_002.save

		product_03 = Product.new :name => "300元购车抵用券",
							  :sales_point => 300,
							  :original_point => 300,
							  :product_img_url => "product/03.png",
							  :inventory => 100,
							  :description => "购车券使用说明：<br />1、购车抵用券每次只能使用一张，不可叠加使用。可在东风标致成都区域各网点使用。<br />2、购车券不折现，不找零。只可用于购车整车使用，不得用于购买其他附件产品。<br />3、东风标致成都区域保留对本券使用方式最终解释权。",
							  :create_time => Time.new

		product_03.save

		product_003 = Product.new :name => "300元保养抵用券",
							  :sales_point => 300,
							  :original_point => 300,
							  :product_img_url => "product/003.png",
							  :inventory => 100,
							  :description => "保养券使用说明：<br />1、保养券需在所购车网点使用，且保养车型须为东风标致车型。<br/>2、每次保养只能使用一张，该券不可兑换为现金使用，且不找零。<br/>3、东风标致成都区域保留对本券使用方式最终解释权。",
							  :create_time => Time.new

		product_003.save

		product_04 = Product.new :name => "400元购车抵用券",
							  :sales_point => 400,
							  :original_point => 400,
							  :product_img_url => "product/04.png",
							  :inventory => 100,
							  :description => "购车券使用说明：<br />1、购车抵用券每次只能使用一张，不可叠加使用。可在东风标致成都区域各网点使用。<br />2、购车券不折现，不找零。只可用于购车整车使用，不得用于购买其他附件产品。<br />3、东风标致成都区域保留对本券使用方式最终解释权。",
							  :create_time => Time.new

		product_04.save

		product_004 = Product.new :name => "400元保养抵用券",
							  :sales_point => 400,
							  :original_point => 400,
							  :product_img_url => "product/004.png",
							  :inventory => 100,
							  :description => "保养券使用说明：<br />1、保养券需在所购车网点使用，且保养车型须为东风标致车型。<br/>2、每次保养只能使用一张，该券不可兑换为现金使用，且不找零。<br/>3、东风标致成都区域保留对本券使用方式最终解释权。",
							  :create_time => Time.new

		product_004.save

		product_05 = Product.new :name => "800元购车抵用券",
							  :sales_point => 800,
							  :original_point => 800,
							  :product_img_url => "product/05.png",
							  :inventory => 100,
							  :description => "购车券使用说明：<br />1、购车抵用券每次只能使用一张，不可叠加使用。可在东风标致成都区域各网点使用。<br />2、购车券不折现，不找零。只可用于购车整车使用，不得用于购买其他附件产品。<br />3、东风标致成都区域保留对本券使用方式最终解释权。",
							  :create_time => Time.new

		product_05.save

		product_005 = Product.new :name => "800元保养抵用券",
							  :sales_point => 800,
							  :original_point => 800,
							  :product_img_url => "product/005.png",
							  :inventory => 100,
							  :description => "保养券使用说明：<br />1、保养券需在所购车网点使用，且保养车型须为东风标致车型。<br/>2、每次保养只能使用一张，该券不可兑换为现金使用，且不找零。<br/>3、东风标致成都区域保留对本券使用方式最终解释权。",
							  :create_time => Time.new

		product_005.save

		product_06 = Product.new :name => "1000元购车抵用券",
							  :sales_point => 1000,
							  :original_point => 1000,
							  :product_img_url => "product/06.png",
							  :inventory => 100,
							  :description => "购车券使用说明：<br />1、购车抵用券每次只能使用一张，不可叠加使用。可在东风标致成都区域各网点使用。<br />2、购车券不折现，不找零。只可用于购车整车使用，不得用于购买其他附件产品。<br />3、东风标致成都区域保留对本券使用方式最终解释权。",
							  :create_time => Time.new

		product_06.save

		product_006 = Product.new :name => "1000元保养抵用券",
							  :sales_point => 1000,
							  :original_point => 1000,
							  :product_img_url => "product/006.png",
							  :inventory => 100,
							  :description => "保养券使用说明：<br />1、保养券需在所购车网点使用，且保养车型须为东风标致车型。<br/>2、每次保养只能使用一张，该券不可兑换为现金使用，且不找零。<br/>3、东风标致成都区域保留对本券使用方式最终解释权。",
							  :create_time => Time.new

		product_006.save

		product_shizi = Product.new :name => "东风标致狮子人偶",
							  :sales_point => 100,
							  :original_point => 100,
							  :product_img_url => "product/shizi.png",
							  :inventory => 100,
							  :description => "东风标致狮子人偶",
							  :create_time => Time.new

		product_shizi.save

		product_xichenqi = Product.new :name => "车载吸尘器",
							  :sales_point => 200,
							  :original_point => 200,
							  :product_img_url => "product/xichenqi.png",
							  :inventory => 100,
							  :description => "车载吸尘器",
							  :create_time => Time.new

		product_xichenqi.save


		product_dianfanguo = Product.new :name => "电饭锅",
							  :sales_point => 300,
							  :original_point => 300,
							  :product_img_url => "product/dianfanguo.png",
							  :inventory => 100,
							  :description => "电饭锅",
							  :create_time => Time.new

		product_dianfanguo.save

		product_huiyinbi = Product.new :name => "高档回音壁",
							  :sales_point => 400,
							  :original_point => 400,
							  :product_img_url => "product/huiyibi.png",
							  :inventory => 100,
							  :description => "高档回音壁",
							  :create_time => Time.new

		product_huiyinbi.save

		product_binxiang = Product.new :name => "品牌电冰箱",
							  :sales_point => 800,
							  :original_point => 800,
							  :product_img_url => "product/binxiang.png",
							  :inventory => 100,
							  :description => "品牌电冰箱",
							  :create_time => Time.new

		product_binxiang.save


		product_dianshi = Product.new :name => "42寸液晶电视",
							  :sales_point => 1000,
							  :original_point => 1000,
							  :product_img_url => "product/dianshi.png",
							  :inventory => 100,
							  :description => "42寸液晶电视",
							  :create_time => Time.new

		product_dianshi.save
	end

	def self.down
		drop_table :admins
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
		drop_table :car_owners
	end
end
