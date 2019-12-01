# frozen_string_literal: true

class FieldsController < ApplicationController
  def index
    authorize(Field)
    fields = Field.all
    render jsonapi: fields
  end

  def create
    authorize(Field)
    field1 = Field.new(field_params)
    if field1.save
      render json: { fieldSaved: true, projorcount: Projor.count }
    else
      render json: { fieldSaved: false }
    end
  end

  def show
    authorize(Field)
    render jsonapi: Field.find(params[:id])
  end

  def edit
    authorize(Field)
  end

  def update
    authorize(Field)
    field = Field.find(params[:id])
    if field.update(field_params)
      render json: { newtitle: field.title }
    else
      render json: { newtitle: 'not updated' }
    end
  end

  def destroy
    authorize(Field)
    field = Field.find(params[:id])
    field.destroy
    render json: { fieldcounted: Field.count }
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
