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
end