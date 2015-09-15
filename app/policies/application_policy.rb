class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    true
  end

  def show?
    scope.where(:id => record.id).exists?
  end

  def get_related_resource?
    show?
  end

  def get_related_resources?
    index?
  end

  def create?
    false
  end

  def update?
    false
  end

  def destroy?
    false
  end

  def scope
    self.class::Scope.new(user, record.class).resolve
  end

  delegate :model_class, to: :class

  # retrieve policies of other records to determine authorization
  def policy(record)
    Pundit.policy!(user, record)
  end

  def in_scope?
    scope.where(:id => record.id).exists?
  end

  class << self
    def model_class
      to_s[/.+(?=Policy)/].constantize
    end
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.none
    end
  end
end
