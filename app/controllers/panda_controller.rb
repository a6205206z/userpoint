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
		agency = Agency.find_by(login_name: params[:loginname], login_password: UserInfo.hash_password(params[:password]))

		if !agency.nil?
			agency_session = AgencySession.new agency

			if agency_session.save
				redirect_to "/panda/index"
			else
				redirect_to "/panda/login"
			end
		else
			redirect_to "/panda/login"
		end
	end

	def index
		if !current_agency.nil?
			@userlist = UserInfo.order("real_name")
			@buycarrequests = BuyCarRequest.where(agency_id: current_agency.id).order("status,create_time DESC")
		else
			redirect_to "/panda/login"
		end
	end

	def generate_code
		if !current_agency.nil?
			user = UserInfo.find_by(id: params[:userid])
			if !user.nil?
				if CodeSource.find_by(user_id: user.id).nil?
					code = CodeSource.new :user_id => user.id,
										  :code => CodeSource.generate_code(user.login_name),
										  :add_point => 200,
										  :add_money => 1000,
										  :from_agency_id => current_agency.id,
										  :remarks => "来自" << current_agency.name << "的代码",
										  :create_time => Time.new,
										  :expire_time => t1 = Time.mktime(2025)
					code.save
				else
					@resultMsg = "该用户已经有代码"
				end
				@resultMsg = "代码生成成功"
			else
				@resultMsg = "用户不存在"
			end
		else
			redirect_to "/panda/login"
		end
	end

	def pass_buy_car_request
		if !current_agency.nil?
			request = BuyCarRequest.find_by(id: params[:reqid], agency_id: current_agency.id, status: 0)
			if !request.nil?
				request.status = params[:status] #0 待审核 1 审核通过 2 审核不通过
				

				if request.save
					moneyio_status = 1
					if request.status == 1
						moneyio_status = 3
					end
					totalmoney = 0
					request.money_io_ids.split(',').each do |mid|
						moneyio = UserMoneyIO.find_by(id: mid, status: 2)
						if !moneyio.nil?
							moneyio.status = moneyio_status
							if moneyio.save
								totalmoney += moneyio.money
							end
						end
					end

					if moneyio_status == 1
						user = UserInfo.find_by(id: request.user_id)
						user.user_money += totalmoney
						user.save
					end
				end


				@resultMsg = "修改成功"
			else
				@resultMsg = "找不到记录，或记录无效"
			end
		else
			redirect_to "/panda/login"
		end
	end
end