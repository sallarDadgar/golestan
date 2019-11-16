class ProfsController < ApplicationController
  def index
  end

  def create
      prof = Prof.new(prof_params)
      prof.user.role = 'prof'

      if prof.save
          render json: {profSaved: true}
      else
        #   binding.pry
          render json: {profSaved: false}
      end
  end

  private

  def prof_params
      params.require(:prof).permit(
          :college,:experience,
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
