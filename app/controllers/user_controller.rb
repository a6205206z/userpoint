# User Point project
#
#file: user_controller.rb
#author: cean cheng
#email: cean.ch@gmail.com
#description: controller for user
#

class UserController < ApplicationController
	def register
		@user = UserInfo.new
	end

	def create_user
		@resultMsg = ""
		new_user = UserInfo.new(user_info_params)
		new_user.login_password = UserInfo.hash_password(new_user.login_password)
		new_user.create_time = Time.new
		new_user.user_point = 0
		new_user.user_money = 0
		if new_user == 1
			new_user.profile = "profile/man.png"
		else
			new_user.profile = "profile/woman.png"
		end
		

		if new_user.save
			#create user code
			code = CodeSource.new :user_id => new_user.id,
					  :code => CodeSource.generate_code(new_user.login_name),
					  :add_point => 100,
					  :add_money => 500,
					  :from_agency_id => 0,
					  :remarks => "非车主代码",
					  :create_time => Time.new,
					  :expire_time => t1 = Time.mktime(2025)
			code.save
			@resultMsg = "用户" << new_user.login_name << "创建成功，赶快去体验吧！"
		else
			@resultMsg  = "用户" << new_user.login_name << "创建失败,尝试更换用户名！"
		end
	end


	def login
		
	end

	def sign_out
		if !current_user_info_session.nil?
			current_user_info_session.destroy
		end

		redirect_to "/"
	end

	def sign_in
		user = UserInfo.find_by(login_name: params[:loginname], login_password: UserInfo.hash_password(params[:password]))

		if !user.nil?
			user_session = UserInfoSession.new user

			if user_session.save
				redirect_to "/user/index"
			else
				redirect_to "/user/login"
			end
		else
			redirect_to "/user/login"
		end
	end

	def index
		if !current_user_info.nil?
			@user = UserInfo.find_by(id: current_user_info.id)
			@user_code_my = CodeSource.find_by(user_id: current_user_info.id)
			@carowner = CarOwner.find_by(user_id: current_user_info.id)
			#@users = User.where(name: 'David', occupation: 'Code Artist').order('created_at DESC')
		else
			redirect_to "/user/login"
		end
	end

	def user_point_io
		if !current_user_info.nil?
			@point_ios = UserPointIO.where(user_id: current_user_info.id).order('operate_time DESC')
		else
			redirect_to "/user/login"
		end
	end

	def user_money_io
		if !current_user_info.nil?
			@money_ios = UserMoneyIO.where(user_id: current_user_info.id).order('operate_time DESC')
		else
			redirect_to "/user/login"
		end
	end

	def user_input_code
		
	end

	def order_list
		if !current_user_info.nil?
			@orderlist = Order.where(user_id: current_user_info.id).order("create_time DESC")
		else
			redirect_to "/user/login"
		end
	end

	def order_detail
		@order = Order.find_by(id: params[:id])
		if !@order.nil? and @order.status == 1
			@itemlist = OrderItem.where(order_id: @order.id)
			@shipping = OrderShipping.find_by(order_id: @order.id)
		end
	end

	def buy_car_request
		if !current_user_info.nil?
	 		@buycarrequests = BuyCarRequest.where(user_id: current_user_info.id).order("create_time DESC")
	 	else
			redirect_to "/user/login"
		end
	end

	def add_point_by_code
		if !current_user_info.nil?
			@resultMsg = ""

			
			user_code = CodeSource.where("code = '#{params[:code]}' and user_id <> #{current_user_info.id} and ('#{Time.new}' between create_time and expire_time)").first
			

			#if io has no record
			if !user_code.nil?
				#get agency
				agency = Agency.find_by(id: user_code.from_agency_id)
				if !agency.nil?

					code_user = UserInfo.find_by(id: user_code.user_id)
				 	money_ios = UserMoneyIO.find_by(code: params[:code], user_id: current_user_info.id)
					#if user code has recorde
					if money_ios.nil?

						user = UserInfo.find_by(id: current_user_info.id)
						if !user.nil?
							user.user_money += user_code.add_money
							user.save




							#add money io
							money_io = UserMoneyIO.new :user_id => user.id,
											:money => user_code.add_money,
											:remarks => "使用了" << code_user.real_name << "的认证车主代码[" << user_code.code << "]，来自[" << agency.name << "]",
									   		:status => 1,
									   		:code => user_code.code,
									   		:from_agency_id => agency.id,
									   		:operate_time => Time.new

							money_io.save


							@resultMsg = "获得#{agency.name}的#{user_code.add_money}元购车基金,赶紧去购车吧"
						else
							@resultMsg = "该用户不存在"
						end
					else
						@resultMsg = "ERROR:该用户已经使用过 #{params[:code]}"
					end
				else #非车主代码
					
					code_user = UserInfo.find_by(id: user_code.user_id)
				 	money_ios = UserMoneyIO.find_by(code: params[:code], user_id: current_user_info.id)
					#if user code has recorde
					if money_ios.nil?

						user = UserInfo.find_by(id: current_user_info.id)
						if !user.nil?
							user.user_money += user_code.add_money
							user.save




							#add money io
							money_io = UserMoneyIO.new :user_id => user.id,
											:money => user_code.add_money,
											:remarks => "使用了" << code_user.real_name << "的代码[" << user_code.code << "]",
									   		:status => 1,
									   		:code => user_code.code,
									   		:from_agency_id => 0,
									   		:operate_time => Time.new

							money_io.save


							@resultMsg = "获得#{code_user.real_name}的#{user_code.add_money}元购车基金,赶紧去购车吧"
						else
							@resultMsg = "该用户不存在"
						end
					else
						@resultMsg = "ERROR:该用户已经使用过 #{params[:code]}"
					end
				end
			else
				@resultMsg = "ERROR:代码 #{params[:code]} 无效或已经过期"
			end
		else
			redirect_to "/user/login"
		end
	end

	private

	def user_info_params
		params.require(:user_info).permit(:login_name, :login_password, :real_name, :sex, :create_time, :user_point, :user_money, :profile, :persistence_token)
	end
end