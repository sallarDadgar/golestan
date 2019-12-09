class ApplicationController < ActionController::Base
  include Pundit
  # after_action :authenticate_user!, only: :create
  before_action :authenticate_user!, except: :app
  protect_from_forgery prepend: true
  # with: :null_sessions

  def app
    if user_signed_in?
      render template: 'layouts/app'
    else
      render template: 'layouts/auth'
    end
  end

  private

  def authenticate_user!
    return super if user_signed_in?
    render json: { messages: 'you are not logged in!' }
  end
end
