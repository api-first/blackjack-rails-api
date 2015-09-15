module ReadOnlyPolicy
  extend ActiveSupport::Concern

  def show?
    true
  end

  included do
    class self::Scope < ApplicationPolicy::Scope
      def resolve
        scope.all
      end
    end
  end

end
