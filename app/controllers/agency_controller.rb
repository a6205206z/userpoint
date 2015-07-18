class AgencyController < ApplicationController
	def buy_car
		if !current_user_info.nil?
			@agency = Agency.find_by(id: params[:agencyid])
			if !@agency.nil?
				@moneyio = UserMoneyIO.find_by(id: params[:moneyioid], user_id: current_user_info.id)
			end
		else
			redirect_to "/user/login"
		end
	end

	def input_buy_car_info
		@resultMsg = ""

		if !current_user_info.nil?
			mids = ""
			moneyioid = params[:moneyioid]

			buycarreq = BuyCarRequest.new :user_id => current_user_info.id,
									  	  :agency_id => params[:agencyid],
									  	  :user_id_number => params[:idnumber],
									  	  :req_info => "用户[" << current_user_info.real_name << "]电话[" << params[:phonenumber] << "]使用购车基金,购买[" << params[:brand] << params[:model] << params[:type] << "]",
									  	  :money_io_id => moneyioid,
									  	  :create_time => Time.new,
									  	  :status => 0
			if buycarreq.save
				totalmoney = 0.00
				moneyio = UserMoneyIO.find_by(id: moneyioid, status: 1)
				if !moneyio.nil?
					totalmoney += moneyio.money
					moneyio.status = 2
					moneyio.save
				end

				user = UserInfo.find_by(id: current_user_info.id)
				user.user_money -= totalmoney
				user.save
				@resultMsg = "申请成功，请耐心等待审核。"
			else
				@resultMsg = "申请失败，请联系经销商。"
			end	
		else
			redirect_to "/user/login"
		end
	end
end