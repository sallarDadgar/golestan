class FieldsController < ApplicationController
  def index
    authorize(Prof)
    fields = Field.all
    render jsonapi: fields
  end

  def create
    authorize(Prof)
    field1 = Field.new(field_params)
    if field1.save
        render json: {fieldSaved: true}
    else
        render json: {fieldSaved: false}
    end
  end

  def show
    authorize(Prof)
    render jsonapi: Field.find(params[:id])
  end

  def edit
    authorize(Prof)
  end

  def update
    authorize(Prof)
    field = Field.find(params[:id])
    if field.update(field_params)
      render json: { newtitle: field.title}
    else
      render json: { newtitle: 'not updated'}
    end
  end

  def destroy
    authorize(Prof)
    field = Field.find(params[:id])
    field.destroy
    render json: {fieldcounted: Field.count}
  end

  private

  def field_params
      params.require(:field).permit(
          :title, :unit, :fkey_id, :fkey_type
      )
  end
end