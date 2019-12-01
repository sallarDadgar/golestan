class ApplicationController < ActionController::Base
  include Pundit
  # before_action :authenticate_user!
  protect_from_forgery prepend: true

  def app
    #   redirect_unless('admin') && return
    render 'layouts/application'
  end

  private

  def authenticate_user!

    return super if user_signed_in?

    render json: { messages: 'you are not logged in!' }
  end
end
