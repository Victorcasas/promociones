class CalculosController < ApplicationController

  def new
    @calculo = Calculo.new
  end

  def create
    
  end

  private

  def secure_params
    params.require(:calculo).permit(:cantidadAM, :cantidadAC, :cantidadCA)
  end

end
