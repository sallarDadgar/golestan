# frozen_string_literal: true

class ReshtehsController < ApplicationController
  def index
    authorize(Reshteh)
    reshtehs = Reshteh.all
    render jsonapi: reshtehs, include: ['fields', 'fields.projor']
  end

  def create
    authorize(Reshteh)
    reshteh1 = Reshteh.new(reshteh_params)
    if reshteh1.save
      # render json: {reshte: Reshteh.count, field: Field.count, projor: Projor.count}
      render jsonapi: reshteh1, include: ['fields']
    else
      render json: reshteh1.errors, status: :unprocessable_entity
    end
  end

  def show
    authorize(Reshteh)
    reshteh1 = Reshteh.find(params[:id])
    render jsonapi: reshteh1, include: ['fields']
  end

  def edit
    authorize(Reshteh)
  end

  def update
    authorize(Reshteh)
    reshteh = Reshteh.find(params[:id])
    if reshteh.update(reshteh_params)
      render jsonapi: reshteh, include: ['fields']
    else
      render json: reshteh.errors, status: :unprocessable_entity
    end
  end

  def destroy
    authorize(Reshteh)
    reshteh = Reshteh.find(params[:id])
    if reshteh.destroy
      render json: { reshteh_destroyed: 'reshteh was destroyed' }
    else
      render json: reshteh.errors
    end
  end

  private

  def reshteh_params
    params.require(:reshteh).permit(
      :title,
      fields_attributes: %i[
        id
        title
        unit
        projor_attributes: %i[
          prof
        ]
      ]
    )
  end
end
