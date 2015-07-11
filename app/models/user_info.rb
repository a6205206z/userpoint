require "digest/sha1"

class UserInfo < ActiveRecord::Base
	acts_as_authentic
	  # Return password digest
	def self.hash_password(clear_password)
		Digest::SHA1.hexdigest(clear_password || "")
	end
end