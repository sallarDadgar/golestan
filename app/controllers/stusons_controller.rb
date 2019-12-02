# frozen_string_literal: true

class StusonsController < ApplicationController
  def create
    authorize(Stuson)
    stuson = Stuson.new(stuson_params)
    if stuson.save
      render jsonapi: stuson
    else
      render json: stuson.errors
    end
  end

  def update
    authorize(Stuson)
    stuson = Stuson.find(params[:id])
    # stuson.update_attributes!(stuson_params)
    if stuson.update(stuson_params)
      render jsonapi: stuson
    else
      render json: stuson.errors
    end
  end

  private

  def stuson_params
    params.require(:stuson).permit(
      :lesson,
      :mark,
      :fk_id,
      :fk_type
    )
  end
end
