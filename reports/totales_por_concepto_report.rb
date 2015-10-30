class TotalesPorConceptoReport

  attr_reader :sueldo_basico, :antiguedad, :presentismo, :inasistencias, :dias_inasistencias, :vacaciones, :dias_vacaciones
  attr_reader :aguinaldo, :suma_no_remunerativa, :jubilacion, :ley_pami, :obra_social, :cuota_sindical, :faecys
  attr_accessor :recibos

  def initialize(recibos)
    @recibos = recibos
  end

  def generar
 #   @sueldo_basico          = @recibos.sum(:sueldo_basico)
     @antiguedad = 22
 #   @presentismo            = @recibos.sum(:presentismo)
 #   @inasistencias          = @recibos.sum(:inasistencias)
 #   @dias_inasistencias     = @recibos.sum(:dias_inasistencias)
 #   @vacaciones             = @recibos.sum(:vacaciones)
 #   @dias_vacaciones        = @recibos.sum(:dias_vacaciones)
 #   @aguinaldo              = @recibos.sum(:aguinaldo)
 #   @suma_no_remunerativa   = @recibos.sum(:suma_no_remunerativa)
 #   @jubilacion             = @recibos.sum(:jubilacion)
 #   @ley_pami               = @recibos.sum(:ley_pami)
 #   @obra_social            = @recibos.sum(:obra_social)
 #   @cuota_sindical         = @recibos.sum(:cuota_sindical)
 #   @faecys                 = @recibos.sum(:faecys)
 #   #calcular_totales
  end

  private

  def calcular_totales
  end
end
