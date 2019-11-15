# frozen_string_literal: true

class SessionsController < Devise::SessionsController
  def create
    resource = warden.authenticate!(scope: resource_name, recall: 'sessions#failure')
    sign_in_and_redirect(resource_name, resource)
  end

  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    if signed_out
      render json: { logout: true }
    else
      render json: { logout: false}
    end
  end

  def sign_in_and_redirect(resource_or_scope, resource = nil)
    scope = Devise::Mapping.find_scope!(resource_or_scope)
    resource ||= resource_or_scope
    sign_in(scope, resource) unless warden.user(scope) == resource
      render json: { success: true }
  end

  def failure
    render json: { success: false, errors: ['Login failed.'] }
  end

  def respond_to_on_destroy
    render json: { logout: true}
  end
end