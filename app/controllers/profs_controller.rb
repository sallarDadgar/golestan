# frozen_string_literal: true

class ProfsController < ApplicationController
  def index
    authorize(Prof)
    profs = Prof.all
    render jsonapi: profs, include: ['user']
  end

  def create
    authorize(Prof)
    prof = Prof.new(prof_params)
    prof.user.role = 'prof'

    if prof.save
      render jsonapi: prof, include: ['user']
    else
      #   binding.pry
      render json: prof.errors, status: :unprocessable_entity
    end
  end

  def show
    authorize(Prof)
    render jsonapi: Prof.find(params[:id]), include: ['user']
  end

  def edit; end

  def update
    authorize(Prof)
    prof = Prof.find(params[:id])
    # prof.update_attributes!(prof_params)
    if prof.update(prof_params)
      render jsonapi: prof, include: ['user']
    else
      render json: prof.errors, status: :unprocessable_entity
    end
  end

  def destroy
    authorize(Prof)
    prof = Prof.find(params[:id])
    if prof.destroy
      render json: { prof_destroyed: 'prof was destroyed' }
    else
      render json: prof.errors
    end
  end

  private

  def prof_params
    params.require(:prof).permit(
      :college, :experience,
      user_attributes: %i[
        id
        profile
        frst_name
        last_name
        email
        password
        password_confirmation
        code
      ]
    )
  end
end
