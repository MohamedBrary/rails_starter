class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

	include Pundit
	# TODO remove after authorization logic is complete
	# after_action :verify_authorized, except: :index
 #  after_action :verify_policy_scoped, only: :index
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = "Sorry! You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end
end
