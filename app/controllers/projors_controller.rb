class ProjorsController < ApplicationController

  def create
    projor1 = Projor.new(prjor_params)
    if projor1.save
      render json: {projorsaved: true}
    end
  end

  private

  def prjor_params
    params.require(:prof).permit(:prof)
  end
end