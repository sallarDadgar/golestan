class UserPolicy < ApplicationPolicy
  def index?
    user.admin? or user.prof?
  end

end
