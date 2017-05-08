class WelcomeController < ApplicationController
	# skip_after_action :verify_policy_scoped, :only => :index
	# skip_after_action :verify_authorized, :only => :index
	skip_before_action :authenticate_user!, :only => [:index]
	
	def index
  end
end
