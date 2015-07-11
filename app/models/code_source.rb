class CodeSource < ActiveRecord::Base
	validates :user_id, :presence => true, :uniqueness => {:message => "This user already has a code"}
end