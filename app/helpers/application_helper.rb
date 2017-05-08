module ApplicationHelper
	def user_roles
		User.roles.keys.map{|r|[ r.titleize, r]}.to_h
	end

	def edit_user_or_registeration_path user
		current_user == user ? edit_user_registration_path(user) : edit_user_path(user)
	end
end
