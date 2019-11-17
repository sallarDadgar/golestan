class AdminsController < ApplicationController
  def index
    admins = Admin.all
    render jsonapi: admins
  end

  def create
      admin = Admin.new(admin_params)
      admin.user.role = 'admin'

      if admin.save
          render json: {adminSaved: true}
      else
        #   binding.pry
          render json: {adminSaved: false}
      end
  end

  private

  def admin_params
      params.require(:admin).permit(
          :age,:nationality,
          user_attributes: [
            #   :id,
              :profile,
              :frst_name,
              :last_name,
              :email,
              :password,
              :code,
          ]
      )
  end
end
