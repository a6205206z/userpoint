class CodeSource < ActiveRecord::Base
	validates :user_id, :presence => true, :uniqueness => {:message => "This user already has a code"}

	def self.generate_code(str)
		out_chars = ""
		chars = ["a" , "b" , "c" , "d" , "e" , "f" , "g" , "h" ,"i" , "j" , "k" , "l" , "m" , "n" , "o" , "p" , "q" , "r" , "s" , "t" ,"u" , "v" , "w" , "x" , "y" , "z" , "0" , "1" , "2" , "3" , "4" , "5" ,"6" , "7" , "8" , "9" , "A" , "B" , "C" , "D" , "E" , "F" , "G" , "H" ,"I" , "J" , "K" , "L" , "M" , "N" , "O" , "P" , "Q" , "R" , "S" , "T" ,"U" , "V" , "W" , "X" , "Y" , "Z" ]
		str = Digest::SHA1.hexdigest(str || "")
		for i in 0..3
			out_chars = ""
			tmpstr = str[i.*(8),i.*(8) + 8]
			hexlong = 0x3FFFFFFF.&(tmpstr.to_i(16))

			for j in 0..5
				index = 0x0000003D.&(hexlong)
				out_chars += chars[index]

				hexlong = hexlong.>>(5)
			end 
		end

		return out_chars
	end
end