class StusonPolicy < ApplicationPolicy
  attr_reader :user, :record

  def update?
    user.prof?
  end
end