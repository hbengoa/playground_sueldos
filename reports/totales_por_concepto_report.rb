class TotalesPorConceptoReport
  attr_reader :sueldo_basico, :antiguedad, :presentismo, :inasistencias, :dias_inasistencias, :vacaciones, :dias_vacaciones,
              :aguinaldo, :suma_no_remunerativa, :jubilacion, :ley_pami, :obra_social, :cuota_sindical, :faecys

  def initialize(empresa, desde_fecha, hasta_fecha)
    @empresa     = empresa
    @desde_fecha = desde_fecha
    @hasta_fecha = hasta_fecha
    generar
  end

  def recibos
    @recibos ||= @empresa.recibos.where('fecha between ? and ?', @desde_fecha, @hasta_fecha)
  end

  private

  def generar
    @sueldo_basico          = recibos.sum(:basico) || 0
    @antiguedad             = recibos.sum(:antiguedad)
    @presentismo            = recibos.sum(:presentismo)
    @inasistencias          = recibos.sum(:inasistencias)
    @dias_inasistencias     = recibos.sum(:dias_inasistencias)
    @vacaciones             = recibos.sum(:vacaciones)
    @dias_vacaciones        = recibos.sum(:dias_vacaciones)
    @aguinaldo              = recibos.sum(:aguinaldo)
    @suma_no_remunerativa   = recibos.sum(:suma_no_remunerativa)
    @jubilacion             = recibos.sum(:jubilacion)
    @ley_pami               = recibos.sum(:ley_pami)
    @obra_social            = recibos.sum(:obra_social)
    @cuota_sindical         = recibos.sum(:cuota_sindical)
    @faecys                 = recibos.sum(:faecys)
 #   #calcular_totales
    self
  end

  def calcular_totales
  end
end
