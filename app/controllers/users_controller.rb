class UsersController < ApplicationController
  def index
    authorize(User)
    users = User.all
    render jsonapi: users
  end

  def create
  end
end