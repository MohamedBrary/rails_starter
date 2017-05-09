class UserPolicy < ApplicationPolicy
  
  class Scope < Scope
  	# admin can see all current_users, other type of current_users can only see themselves
    def resolve
      if current_user.admin? || current_user.manager?
        scope.all
      else
        scope.where(id: current_user.id)
      end
    end
  end

  def show?
    super && (current_user_allowed_to_crud? || current_user == record)
  end

  # allowing user to delete himself
  def destroy?
    current_user_allowed_to_crud? || current_user == record
  end

  # allowing user to edit himself
  def update?
    current_user_allowed_to_crud? || current_user == record
  end

  def permitted_attributes
    # normal users can't change their own role
    attributes = [:name, :email, :password, :password_confirmation, :reset_password_token, :role]
    (current_user && current_user_allowed_to_crud?) ? attributes : (attributes - [:role])
  end

  protected
  
  def current_user_allowed_to_crud?
    current_user.admin? || current_user.manager?
  end
end
