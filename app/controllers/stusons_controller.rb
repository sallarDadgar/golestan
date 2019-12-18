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

  def destroy
    student_id = params[:id].to_i
    stusons_ids_delete = []
    stusons = Stuson.all
    stusons.each do |stuson|
      if(stuson.fk_id == student_id)
        stusons_ids_delete.push(stuson.id)
      end
    end
    stusons_ids_delete.each do |deleteId|
      stuson = Stuson.find(deleteId)
      stuson.destroy
    end
    render json: { stuson_destroyed: 'stuson was destroyed' }



    # stuson = Stuson.find(params[:id])
    # if stuson.destroy
    #   render json: { stuson_destroyed: 'stuson was destroyed' }
    # else
    #   render json: stuson.errors
    # end
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
