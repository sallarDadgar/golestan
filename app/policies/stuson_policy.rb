class StusonPolicy < ApplicationPolicy
  attr_reader :user, :record
  def create?
    user.student? or user.admin?
  end
  def update?
    user.prof?
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.admin?
        scope.all
      elsif user.student?
        scope.where(fk_id: student.id)
      end
    end
  end
end