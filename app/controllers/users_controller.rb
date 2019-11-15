class UsersController < ApplicationController
  def index
    render json: {data: true}
  end

  def create
  end
end