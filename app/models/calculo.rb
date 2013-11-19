class Calculo < ActiveRecord::Base
  has_no_table

  column :cantidadAM, :int
  column :cantidadAC, :int
  column :cantidadCA, :int

  

  def obtener_calculo
    
  end

end
