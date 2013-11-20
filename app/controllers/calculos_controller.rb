class CalculosController < ApplicationController

  def new
    @calculo = Calculo.new
  end
  
  def create
    @calculo = Calculo.new(secure_params)
    if @calculo.valid?
      flash[:notice] = "Precio total: #{@calculo.obtener_calculo} €"
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def secure_params
    params.require(:calculo).permit(:cantidadAM, :cantidadAC, :cantidadCA)
  end

end
