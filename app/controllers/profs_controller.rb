class ProfsController < ApplicationController
  def index
    authorize(Prof)
    profs = Prof.all
    render jsonapi: profs
  end

  def create
    authorize(Prof)
      prof = Prof.new(prof_params)
      prof.user.role = 'prof'

      if prof.save
          render json: {profSaved: true}
      else
        #   binding.pry
          render json: {profSaved: false}
      end
  end

  def show
    authorize(Prof)
    render jsonapi: Prof.find(params[:id])
  end

  def edit
  end

  def update
    authorize(Prof)
    prof = Prof.find(params[:id])
    prof.update_attributes!(prof_params)
    if prof.update(prof_params)
      render json: { newname: prof.user.frst_name}
    else
      render json: { newname: 'not updated'}
    end
  end

  def destroy
    authorize(Prof)
    prof = Prof.find(params[:id])
    prof.destroy
    render json: {profcounted: Prof.count, usercounted: User.count}
  end

  private

  def prof_params
      params.require(:prof).permit(
          :college,:experience,
          user_attributes: [
              :id,
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
