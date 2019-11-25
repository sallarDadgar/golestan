class ReshtehsController < ApplicationController
  def index
    authorize(Prof)
    reshtehs = Reshteh.all
    render jsonapi: reshtehs
  end

  def create
    authorize(Prof)
      rehteh1 = Reshteh.new(reshteh_params)
      if rehteh1.save
          render json: {reshtehSaved: true}
      else
          render json: {reshtehSaved: false}
      end
  end

  def show
    authorize(Prof)
    render jsonapi: Reshteh.find(params[:id])
  end

  def edit
    authorize(Prof)
  end

  def update
    authorize(Prof)
    reshteh = Reshteh.find(params[:id])
    if reshteh.update(reshteh_params)
      render json: { newtitle: reshteh.title}
    else
      render json: { newtitle: 'not updated'}
    end
  end

  def destroy
    authorize(Prof)
    reshteh = Reshteh.find(params[:id])
    reshteh.destroy
    render json: {reshtehcounted: Reshteh.count}
  end

  private

  def reshteh_params
      params.require(:reshteh).permit(
          :title,
          lessons_attributes: [
            :title,
            :unit
          ]
      )
  end
end