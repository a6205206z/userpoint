class AgencyController < ApplicationController
	def buy_car
		if !current_user_info.nil?
			@agency = Agency.find_by(id: params[:agencyid])
			if !@agency.nil?
				@moneyio = UserMoneyIO.where(user_id: current_user_info.id,status: 1,from_agency_id: @agency.id)
			end
		else
			redirect_to "/user/login"
		end
	end

	def input_buy_car_info
		@resultMsg = ""
		if !current_user_info.nil?
			buycarreq = BuyCarRequest.new :user_id => current_user_info.id,
									  :agency_id => params[:agencyid],
									  :user_id_number => params[:idnumber],
									  :req_info => "用户[" << current_user_info.real_name << "]使用购车基金,购买[" << params[:brand] << params[:model] << params[:type] << "]",
									  :money_io_ids => params[:moneyioids],
									  :create_time => Time.new,
									  :status => 0
			if buycarreq.save
				totalmoney = 0.00
				buycarreq.money_io_ids.split(',').each do |mid|
					moneyio = UserMoneyIO.find_by(id: mid)
					if !moneyio.nil?
						totalmoney += moneyio.money
						moneyio.status = 2
						moneyio.save
					end
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