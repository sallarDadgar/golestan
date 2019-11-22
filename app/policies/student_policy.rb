class StudentPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end


  # attr_reader :student, :record

  # def initialize(user, record)
  #   @student = student
  #   @record = record
  # end

  def index?
    user.admin?
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

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end
  end


  # class Scope
  #   attr_reader :student, :scope

  #   def initialize(student, scope)
  #     @student = student
  #     @scope = scope
  #   end

  #   def resolve
  #     scope.all
  #   end
  # end
end
