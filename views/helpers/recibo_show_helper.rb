class ReciboShowHelper
  def initialize(recibo)
    @recibo = recibo
  end

  def total_remunerativo
    right_format_currency(@recibo.total_remunerativo, 30)
  end

  def total_no_remunerativo
    right_format_currency(@recibo.total_no_remunerativo, 23)
  end

  def total_descuentos
    right_format_currency(@recibo.total_descuentos, 29)
  end

  def total_neto
    right_format_currency(@recibo.total_neto, 19)
  end

  def basico
    right_format_currency(@recibo.basico, 12)
  end

  def anios_antiguedad
    right_format_currency(@recibo.anios_antiguedad, 16)
  end

  def antiguedad
    right_format_currency(@recibo.antiguedad, 23)
  end

  def presentismo
    right_format_currency(@recibo.presentismo, 12)
  end

  def dias_vacaciones
    right_format_currency(@recibo.dias_vacaciones, 16)
  end

  def vacaciones
    right_format_currency(@recibo.vacaciones, 23)
  end

  def dias_inasistencias
    right_format_currency(@recibo.dias_inasistencias, 16)
  end

  def inasistencias
    right_format_currency(@recibo.inasistencias * -1, 23)
  end

  def aguinaldo
    right_format_currency(@recibo.aguinaldo, 12)
  end

  def suma_no_remunerativa
    right_format_currency(@recibo.suma_no_remunerativa, 28)
  end

  def jubilacion
    right_format_currency(@recibo.jubilacion, 23)
  end

  def ley_pami
    right_format_currency(@recibo.ley_pami, 23)
  end

  def obra_social
    right_format_currency(@recibo.obra_social, 23)
  end

  def cuota_sindical
    right_format_currency(@recibo.cuota_sindical, 23)
  end

  def faecys
    right_format_currency(@recibo.faecys, 23)
  end

  private

  def right_format_currency(value, padding)
    value.round(2).to_s.rjust(padding)
  end
end
