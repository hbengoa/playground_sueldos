class TotalesPorConceptoReport
  attr_reader :sueldo_basico, :antiguedad, :presentismo, :inasistencias, :dias_inasistencias, :vacaciones, :dias_vacaciones,
              :aguinaldo, :suma_no_remunerativa, :jubilacion, :ley_pami, :obra_social, :cuota_sindical, :faecys,
              :total_remunerativo, :total_no_remunerativo, :total_descuentos, :total_neto

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
    calcular_totales
    self
  end

  private

  def calcular_totales
    @total_remunerativo = @sueldo_basico + @antiguedad + @presentismo + @inasistencias + @vacaciones + @aguinaldo
    @total_no_remunerativo = @suma_no_remunerativa
    @total_descuentos = @jubilacion + @ley_pami + @obra_social + @cuota_sindical + @faecys
    @total_neto = @total_remunerativo + @total_no_remunerativo - @total_descuentos
    self
  end
end
