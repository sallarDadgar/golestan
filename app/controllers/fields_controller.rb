class FieldsController < ApplicationController
  def index
    fields = Field.all
    render jsonapi: fields
  end

  def create
    field1 = Field.new(field_params)
    if field1.save
        render json: {fieldSaved: true}
    else
        render json: {fieldSaved: false}
    end
  end

  def show
    render jsonapi: Field.find(params[:id])
  end

  def edit
  end

  def update
    field = Field.find(params[:id])
    if field.update(field_params)
      render json: { newtitle: field.title}
    else
      render json: { newtitle: 'not updated'}
    end
  end

  def destroy
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