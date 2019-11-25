class ReshtehsController < ApplicationController
  def index
    reshtehs = Reshteh.all
    render jsonapi: reshtehs
  end

  def create
      rehteh1 = Reshteh.new(reshteh_params)
      if rehteh1.save
          render json: {reshtehSaved: true}
      else
          render json: {reshtehSaved: false}
      end
  end

  def show
    render jsonapi: Reshteh.find(params[:id])
  end

  def edit
  end

  def update
    reshteh = Reshteh.find(params[:id])
    if reshteh.update(reshteh_params)
      render json: { newtitle: reshteh.title}
    else
      render json: { newtitle: 'not updated'}
    end
  end

  def destroy
    reshteh = Reshteh.find(params[:id])
    reshteh.destroy
    render json: {reshtehcounted: Reshteh.count}
  end

  private

  def reshteh_params
      params.require(:reshteh).permit(
          :title
      )
  end
end