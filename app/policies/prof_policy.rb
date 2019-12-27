class ProfPolicy < ApplicationPolicy
  attr_reader :user, :record

  def index?
    user.admin? or user.student?
  end

  def create?
    user.admin?
  end

  def show?
    user.admin?
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin?
  end
end