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
				invoice_url = uploadFile(params[:invoice][:file])
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
				invoice_url = uploadFile(params[:invoice][:file])
				buycarreq = BuyCarRequest.new :user_id => current_user_info.id,
										  	  :agency_id => params[:agencyid],
										  	  :user_name => current_user_info.real_name,
										  	  :user_id_number => params[:idnumber],
										  	  :phonenumber => params[:phonenumber],
										  	  :invoice_url => invoice_url,
										  	  :money_io_id => moneyioid,
										  	  :create_time => Time.new,
										  	  :status => 0
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
    
	def uploadFile(file)    
	   if !file.original_filename.empty?  
	     #生成一个随机的文件名      
	     @filename=getFileName(file.original_filename)         
	     #向dir目录写入文件  
	     File.open("#{RAILS_ROOT}/public/invoice/upload/#{@filename}", "wb") do |f|   
	        f.write(file.read)  
	     end   
	       #返回文件名称，保存到数据库中  
	     return @filename  
	   end  
	end   
	  
	def getFileName(filename)  
	  if !filename.nil?  
	   require 'uuidtools'  
	     filename.sub(/.*./,UUIDTools::UUID.random_create.to_s+'.jpg')
	   end  
	end      
end