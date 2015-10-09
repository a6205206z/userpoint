# User Point project
#
#file: panda_controller.rb
#author: cean cheng
#email: cean.ch@gmail.com
#description: controller for admin
#


class PandaController < ApplicationController
	def login
		
	end

	def sign_in
		admin = Admin.find_by(login_name: params[:loginname], login_password: UserInfo.hash_password(params[:password]))

		if !admin.nil?
			admin_session = AdminSession.new admin

			if admin_session.save
				redirect_to "/panda/index"
			else
				redirect_to "/panda/login"
			end
		else
			redirect_to "/panda/login"
		end
	end

	def sign_out
		if !current_admin_session.nil?
			current_admin_session.destroy
		end

		redirect_to "/panda/login"
	end

	def index
		if !current_admin.nil?
			@buycarrequests = BuyCarRequest.order("status,create_time DESC")
		else
			redirect_to "/panda/login"
		end
	end

	def order_list
		if !current_admin.nil?
			@orderlist = Order.where("status > 0").order("create_time DESC")
		else
			redirect_to "/panda/login"
		end
	end

	def order_detail
		if !current_admin.nil?
			@order = Order.find_by(id: params[:id])
			if !@order.nil? and @order.status > 0
				@itemlist = OrderItem.where(order_id: @order.id)
				@shipping = OrderShipping.find_by(order_id: @order.id)
			end
		else
			redirect_to "/panda/login"
		end
	end

	def change_order_status
		if !current_admin.nil?
			@order = Order.find_by(id: params[:id])
			if !@order.nil?
				@order.status = params[:status]
				@order.save
				@resultMsg = "操作成功"
			end
		else
			redirect_to "/panda/login"
		end
	end

	def car_owner
		if !current_admin.nil?
			@userlist = UserInfo.order("real_name")
		else
			redirect_to "/panda/login"
		end
	end

	def pass_car_owner
		if !current_admin.nil?
			carowner = CarOwner.find_by(id: params[:carownerid])
			if !carowner.nil?
				if params[:status].to_i == 1
					carowner.status = 1
					if carowner.save
						code = CodeSource.find_by(user_id: carowner.user_id)
						code.from_agency_id = carowner.agency_id
						code.add_point = 500
						code.add_money = 1000
						code.save
					end
				else
					carowner.destroy
				end
				@resultMsg = "操作成功"
			else
				@resultMsg = "未找到记录"
			end
		else
			redirect_to "/panda/login"
		end
	end

	def generate_code

	end

	def pass_buy_car_request
		if !current_admin.nil?
			request = BuyCarRequest.where("id = #{params[:reqid]} and (status = 0 or status > 10)").first()
			if !request.nil?
				
				point_rate = 1.0
				if request.status > 10
					point_rate = request.status.to_f / 10
				end

				request.status = params[:status] #0 待审核 1 审核通过 2 审核不通过
				if request.save
					moneyio_status = 1
					if request.status == 1
						moneyio_status = 3
					end

					moneyio = UserMoneyIO.find_by(id: request.money_io_id, status: 2)
					if !moneyio.nil?
						moneyio.status = moneyio_status
						moneyio.save
					end

					user = UserInfo.find_by(id: request.user_id)
					if moneyio_status == 1
						user.user_money += moneyio.money
						user.save

					elsif moneyio_status ==3
						user_code = CodeSource.find_by(code: moneyio.code)
						if !user_code.nil?
							add_point = user_code.add_point*point_rate

							#add point to code user
							code_user = UserInfo.find_by(id: user_code.user_id)
							code_user.user_point += add_point
							code_user.save

							#add point io
							point_io = UserPointIO.new :user_id => code_user.id,
										:point => add_point,
										:remarks => "来自" << user.real_name << "购车基金",
										:status => 1,
										:operate_time => Time.new,
										:from => "/user/addpoint/#{user.id}/#{params[:code]}",
										:code => user_code.code

							point_io.save
						end
					end
				end


				@resultMsg = "操作成功"
			else
				@resultMsg = "操作成功"
			end
		else
			redirect_to "/panda/login"
		end
	end
end