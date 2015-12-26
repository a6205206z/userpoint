class AgencyController < ApplicationController
	def buy_car
		if !current_user_info.nil?
			@agency = Agency.find_by(id: params[:agencyid])
			@moneyio = UserMoneyIO.find_by(id: params[:moneyioid], user_id: current_user_info.id)

			if @moneyio.from_agency_id == 0
				@agencylist = Agency.order("id")
			elsif @moneyio.from_agency_id != 0
				if !@agency.nil? and @moneyio.from_agency_id != @agency.id
					redirect_to "/user/index"
				end
			end
		else
			redirect_to "/user/login"
		end
	end

	def new_car_owner
		@carowner = CarOwner.find_by(user_id:  current_user_info.id)
		@agency = Agency.find_by(id: params[:agencyid])
		@agencylist = Agency.order("id")
	end

	def input_new_car_owner
		@resultMsg = ""
		if !current_user_info.nil?
			agency = Agency.find_by(id: params[:agencyid])
			if !agency.nil? and !params[:invoice].nil?
				invoice_url = uploadFile(params[:invoice][:file],"/public/invoice/upload/")
				carowner = CarOwner.new :user_id => current_user_info.id,
										:agency_id => params[:agencyid],
										:invoice_url => invoice_url,
										:car_number => params[:carnumber],
										:car_brand => params[:brand],
										:car_model => params[:model],
										:car_type => params[:type],
										:create_time => Time.new,
										:status => 0
				carowner.save
				@resultMsg = "申请成功，请耐心等待审核。"
			else
				@resultMsg = "请提交购车发票。"
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

			moneyio = UserMoneyIO.find_by(id: moneyioid, status: 1)
			agency = Agency.find_by(id: params[:agencyid])

			if moneyio.from_agency_id != 0
				if moneyio.from_agency_id != agency.id
					redirect_to "/user/index"
				end
			end 

		

			if !params[:invoice].nil?
				invoice_url = uploadFile(params[:invoice][:file],"/public/invoice/upload/")
				buycarreq = BuyCarRequest.new :user_id => current_user_info.id,
										  	  :agency_id => params[:agencyid],
										  	  :user_name => current_user_info.real_name,
										  	  :user_id_number => params[:idnumber],
										  	  :phonenumber => params[:phonenumber],
										  	  :invoice_url => invoice_url,
										  	  :money_io_id => moneyioid,
										  	  :create_time => Time.new,
										  	  :status => 0

				# if 2008 3008 point * 1.2 508 * 1.5
				if !params[:model].nil? 
					if params[:model].include? "2008" or params[:model].include? "3008"
						buycarreq.status = 12
					elsif params[:model].include? "508"
						buycarreq.status = 15
					end
				end

				if buycarreq.save
					totalmoney = 0.00
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
				@resultMsg = "请提交购车发票。"
			end
		else
			redirect_to "/user/login"
		end
	end

	def configure_charsets          
       @headers["Content-Type"]="text/html;charset=utf-8"      
   	end     
end