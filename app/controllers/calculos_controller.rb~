class CalculosController < ApplicationController

  def new
    @calculo = Calculo.new
  end

  def create
    @calculo = Calculo.new(secure_params)
      flash[:notice] = "Total calculado OK"
      redirect_to root_path
  end

  private

  def secure_params
    params.require(:calculo).permit(:cantidadAM, :cantidadAC, :cantidadCA)
  end

end
