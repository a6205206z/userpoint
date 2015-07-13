# User Point project
#
#file: mall_controller.rb
#author: cean cheng
#email: cean.ch@gmail.com
#description: controller for mall
#

class MallController < ApplicationController
	def index
		offset = params[:page].to_i.*(5)
		@products = Product.order("create_time DESC").limit(5).offset(offset)
	end

	def product_detail
		@product = Product.find(params[:id])
	end
end