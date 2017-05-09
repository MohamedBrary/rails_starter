class Api::V1::BaseController < ApplicationController
  include ModelHash

  # API follows a different authentication technique
  skip_before_action :authenticate_user!

  attr_accessor :current_user, :current_user_token

  protected

  def set_user
    @user = params[:user_id].present? ? User.where(id: params[:user_id]).first : nil
  end

  def requires_authentication_token
    authenticate_or_request_with_http_token do |token, _|
      self.current_user_token = UserToken.find_by access_token: token
      self.current_user = sign_in(:user, current_user_token.user) if current_user_token.try(:user).present?
      current_user.present? ? (current_user_token.try(:touch); true) : false
    end
  end

  def user_not_authorized
    respond_to do |format|
      format.json { render json: {errors: [message: "Sorry! You are not authorized to perform this action."]}, status: :unauthorized }
    end
  end
end
