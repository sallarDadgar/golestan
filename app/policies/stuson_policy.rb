class StusonPolicy < ApplicationPolicy
  attr_reader :user, :record
  def create?
    user.student? or user.admin?
  end
  def update?
    user.prof?
  end
end