require "digest/sha1"

class UserInfo < ActiveRecord::Base
	acts_as_authentic
	  # Return password digest
	def self.hash_password(clear_password)
		Digest::SHA1.hexdigest(clear_password || "")
	end

	def self.get_my_code(login_name)
		Digest::SHA1.hexdigest(login_name || "")
	end

	validates :login_name, :presence => true, :uniqueness => {:message => "This login_name has been used"}

	def self.isFullInfo(id)
		user = UserInfo.find_by(id: id)

	 	if user.id_no == nil or user.id_no == ""
	 		return false
		end
	 	if user.real_name == nil or user.real_name == ""
	 		return false
	 	end
	 	if user.login_name == nil or user.login_name == ""
	 		return false
	 	end

		useraddress = UserAddresses.find_by(user_id: id)
	 	if useraddress == nil
	 		return false
	 	end

		return true
	end
end