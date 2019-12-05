class ApplicationController < ActionController::Base
  include Pundit
  # after_action :authenticate_user!, only: :create
  # before_action :authenticate_user!
  protect_from_forgery prepend: true
  # with: :null_sessions


  def app
    if user_signed_in?
      render 'layouts/application'
    else
      render 'layouts/home.vue'
    end
    # render 'layouts/application'
  end

  private

  def authenticate_user!

    return super if user_signed_in?

    # render '@/javascript/components/home.vue'
    render json: { messages: 'you are not logged in!' }
  end
end
