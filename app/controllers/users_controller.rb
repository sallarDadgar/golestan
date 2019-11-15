class UsersController < ApplicationController
  def index
    users = User.all
    render jsonapi: users
  end

  def create
  end
end