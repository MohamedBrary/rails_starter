class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user

  # GET /users
  # GET /users.json
  def index
    @users = policy_scope(User)
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/1/edit
  def edit
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    user_params.delete(:password) if user_params[:password].blank?
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
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
      # params.require(:user).permit(:name, :email, :password, :password_confirmation, :role)
    end
end
