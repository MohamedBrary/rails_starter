class ApplicationPolicy
  attr_reader :current_user, :record

  def initialize(current_user, record)
    @current_user = current_user
    @record = record
  end

  def index?
    current_user_allowed_to_crud?
  end

  # will catch fishy ids, and not authorized records
  def show?
    !record.is_a?(Class) && record.present? && 
      scope.where(:id => record.id).exists?
  end

  def create?
    current_user_allowed_to_crud?
  end

  def new?
    create?
  end

  def update?
    current_user_allowed_to_crud?
  end

  # will catch fishy ids, and not authorized records
  def edit?
    !record.is_a?(Class) && record.present? && 
      scope.where(:id => record.id).exists? &&
      update?
  end

  def destroy?
    current_user_allowed_to_crud?
  end

  def scope
    Pundit.policy_scope!(current_user, record.class)
  end

  class Scope
    attr_reader :current_user, :scope

    def initialize(current_user, scope)
      @current_user = current_user
      @scope = scope
    end

    def resolve
      scope
    end
  end

  protected
  
  def current_user_allowed_to_crud?
    current_user.admin?
  end
end
