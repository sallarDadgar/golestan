# frozen_string_literal: true

class ReshtehsController < ApplicationController
  def index
    authorize(Reshteh)
    reshtehs = Reshteh.all
    render jsonapi: reshtehs
  end

  def create
    authorize(Reshteh)
    rehteh1 = Reshteh.new(reshteh_params)
    if rehteh1.save
      render json: { reshtehSaved: true }
    else
      render json: { reshtehSaved: false }
    end
  end

  def show
    authorize(Reshteh)
    render jsonapi: Reshteh.find(params[:id])
  end

  def edit
    authorize(Reshteh)
  end

  def update
    authorize(Reshteh)
    reshteh = Reshteh.find(params[:id])
    if reshteh.update(reshteh_params)
      render json: { newtitle: reshteh.title }
    else
      render json: { newtitle: 'not updated' }
    end
  end

  def destroy
    authorize(Reshteh)
    reshteh = Reshteh.find(params[:id])
    reshteh.destroy
    render json: { reshtehcounted: Reshteh.count }
  end

  private

  def reshteh_params
    params.require(:reshteh).permit(
      :title,
      lessons_attributes: %i[
        title
        unit
      ]
    )
  end
end
