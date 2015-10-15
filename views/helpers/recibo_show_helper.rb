class ReciboShowHelper
  def initialize(recibo)
    @recibo = recibo
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
