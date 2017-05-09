class Api::V1::UsersController < Api::V1::BaseController
  before_action :requires_authentication_token, except: %w(create forgot_password reset_password)
  before_action :set_user, only: %w(show update)
  before_action :authorize_user, only: %w(index show update)

  def index
    @users = policy_scope(User)
    respond_to do |format|
      format.json do
        render json: { users: @users }, status: :ok
      end      
    end
  end

  def show
    respond_to do |format|
      if @user.present?
        format.json do
          render json: { user: user_hash(@user) }, status: :ok
        end
      else
        format.json do
          render json: { errors: { id: 'not found' } }, status: :not_found
        end
      end
    end
  end

  def update
    user_params.delete(:password) if user_params[:password].blank?
    respond_to do |format|
      if @user.update(user_params)
        format.json { render json: { user: user_hash(@user) }, status: :ok }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    respond_to do |format|
      user = User.new user_params
      if user.save
        user_token = user.user_tokens.create
        if user_token.persisted?
          format.json do
            render json: { user_token: user_token_hash(user_token, user: true) }, status: :created
          end
        else
          format.json do
            render json: { errors: user_token.errors }, status: :unprocessable_entity
          end
        end
      else
        format.json do
          render json: { errors: user.errors }, status: :unprocessable_entity
        end
      end
    end
  end

  def forgot_password
    respond_to do |format|
      user = User.find_by email: user_params[:email]
      format.json do
        if user.present?
          user.send_reset_password_instructions
          user.save
          render json: { user: user_hash(user).slice(:email) }, status: :ok
        else
          render json: { errors: { email: 'not found' } }, status: :not_found
        end
      end
    end
  end

  def reset_password
    respond_to do |format|
      user = User.reset_password_by_token user_params.slice(:reset_password_token, :password, :password_confirmation)
      format.json do
        if user.present?
          if user.errors.empty?
            render json: { user: user_hash(user) }, status: :ok
          else
            render json: { errors: user.errors }, status: :unprocessable_entity
          end
        else
          render json: { errors: { email: 'not found' } }, status: :not_found
        end
      end
    end
  end

  private

  def set_user
    # making sure that current user has access to the set user
    @user = policy_scope(User).where(id: params[:id]).first
  end

  def authorize_user
    # authorize the set user, or the Class User in case the user isn't initialized
    authorize (@user || User)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(policy(@user || User).permitted_attributes)
  end  
end
