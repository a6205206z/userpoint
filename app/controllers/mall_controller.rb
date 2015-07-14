# User Point project
#
#file: mall_controller.rb
#author: cean cheng
#email: cean.ch@gmail.com
#description: controller for mall
#

class MallController < ApplicationController
	def index
		offset = (params[:page].to_i.-(1)).*(5)
		if offset < 0 
			offset = 0
		end
		
		@products = Product.order("create_time DESC").limit(5).offset(offset)
	end

	def product_detail
		@product = Product.find(params[:id])
	end

	def make_order
		if !current_user_info.nil?
			@error_msg = ""
			product = Product.find(params[:pid])
			user = UserInfo.find(current_user_info.id)

			if user.user_point >= product.sales_point
				order = Order.new :user_id => user.id,
								  :order_point => product.sales_point,
								  :status => 0,
								  :create_time => Time.new,
								  :remarks => "-" << product.sales_point << "兑换" << product.name

				if order.save
					item = OrderItem.new :order_id => order.id,
								  :product_id => product.id,
								  :pre_point => product.sales_point,
								  :count => 1,
								  :total_point => product.sales_point

					item.save
					redirect_to "/mall/shipping?orderid=#{order.id}"
				else
					@error_msg = "订单创建失败"
				end
			else
				@error_msg = "抱歉，积分不足!"
			end
		else
			redirect_to "/user/login"
		end
	end

	def shipping
		@order = Order.find(params[:orderid])
		if @order.status == 0
			@shipping = UserAddresses.find_by(user_id: current_user_info.id)
			if @shipping.nil?
				@shipping = UserAddresses.new
			end

			@user = UserInfo.find(current_user_info.id)
		else
			@error_msg = "订单已过期"
		end
	end

	def create_shipping
		@result_msg = ""
		order = Order.find_by(id: params[:orderid])
		if !order.nil? and order.status == 0
			shipping = OrderShipping.new  :order_id => params[:orderid],
										  :real_name => params[:real_name],
										  :mobile => params[:mobile],
										  :country => params[:country],
										  :province => params[:province],
										  :city => params[:city],
										  :post_code => params[:post_code],
										  :address => params[:address]

			shipping.save
			if UserAddresses.find_by(user_id:current_user_info.id).nil?
				useraddress = UserAddresses.new :user_id => current_user_info.id,
											    :real_name => params[:real_name],
											    :mobile => params[:mobile],
											    :country => params[:country],
											    :province => params[:province],
											    :city => params[:city],
											    :post_code => params[:post_code],
											    :address => params[:address]
				useraddress.save
			end
			order.status = 1

			if order.save
				user = UserInfo.find(current_user_info.id)
				user.user_point -= order.order_point
				if user.save
					#point io
					point_io = UserPointIO.new :user_id => user.id,
										   :point => - order.order_point,
										   :remarks => order.remarks,
										   :status => 1,
										   :operate_time => Time.new,
										   :from => "System",
										   :code => ""
					point_io.save
				end
			end
			@resultMsg = "感谢支持，订单已经提交！"
		else
			@resultMsg = "订单不存在或已过期"
		end
	end
end