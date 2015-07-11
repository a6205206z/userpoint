# User Point project
#
#file: user_controller.rb
#author: cean cheng
#email: cean.ch@gmail.com
#description: controller for user
#



class UserController < ApplicationController
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
			@point_ios = UserPointIO.where(user_id: current_user_info.id).order('operate_time DESC')
			@money_ios = UserMoneyIO.where(user_id: current_user_info.id).order('operate_time DESC')
			#@users = User.where(name: 'David', occupation: 'Code Artist').order('created_at DESC')
		else
			redirect_to "/user/login"
		end
	end

	def add_point_by_code
		@resultMsg = ""

		point_ios = UserPointIO.find_by(user_id: params[:userid], code: params[:code])
		user_code = CodeSource.where("code = '#{params[:code]}' and user_id <> #{params[:userid]} and ('#{Time.new}' between create_time and expire_time)").first

		#if io has no record
		if !user_code.nil?
			#get user code
			
			#if user code has recorde
			if point_ios.nil?

				user = UserInfo.find_by(id: params[:userid])
				if !user.nil?
					user.user_point += user_code.add_point
					user.save

					#add io
					point_io = UserPointIO.new :user_id => user.id,
								:point => user_code.add_point,
								:remarks => params[:msg],
								:status => 1,
								:operate_time => Time.new,
								:from => "/user/addpoint/#{params[:userid]}/#{params[:code]}",
								:code => user_code.code

					point_io.save
					@resultMsg = "成功 + #{user_code.add_point}"
				else
					@resultMsg = "该用户不存在"
				end
			else
				@resultMsg = "ERROR:该用户已经使用过 #{params[:code]}"
			end
		else
			@resultMsg = "ERROR:代码 #{params[:code]} 无效或已经过期"
		end
	end
end