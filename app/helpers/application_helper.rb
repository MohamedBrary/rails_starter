module ApplicationHelper
	def user_roles
		User.roles.keys.map{|r|[ r.titleize, r]}.to_h
	end
end
