# User Point project
#
#file: user_controller.rb
#author: cean cheng
#email: cean.ch@gmail.com
#description: controller for user
#



class UserController < ApplicationController
	def index
		@user = UserInfo.find_by(id: params[:id])
		@point_ios = UserPointIO.where(user_id: params[:id]).order('operate_time DESC')
		#@users = User.where(name: 'David', occupation: 'Code Artist').order('created_at DESC')
	end
end