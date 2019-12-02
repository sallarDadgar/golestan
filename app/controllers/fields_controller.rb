# frozen_string_literal: true

class FieldsController < ApplicationController
  def index
    authorize(Field)
    fields = Field.all
    render jsonapi: fields, include: ['projor']
  end

  def create
    authorize(Field)
    field1 = Field.new(field_params)
    if field1.save
      render jsonapi: field1, include: ['projor']
    else
      render json: field1.errors, status: :unprocessable_entity
    end
  end

  def show
    authorize(Field)
    render jsonapi: Field.find(params[:id]), include: ['projor']
  end

  def edit
    authorize(Field)
  end

  def update
    authorize(Field)
    field = Field.find(params[:id])
    if field.update(field_params)
      render jsonapi: field, include: ['projor']
    else
      render json: field.errors, status: :unprocessable_entity
    end
  end

  def destroy
    authorize(Field)
    field = Field.find(params[:id])
    if field.destroy
      render json: { field_destroyed: 'field was destroyed' }
    else
      render json: field.errors
    end
  end

  private

  def field_params
    params.require(:field).permit(
      :title, :unit, :fkey_id, :fkey_type,
      projor_attributes: [
        :prof
      ]
    )
  end
end
