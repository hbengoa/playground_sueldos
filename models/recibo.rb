require_relative '../helpers/gui'

class Recibo < ActiveRecord::Base
  belongs_to :empleado
  self.table_name = 'recibos'

  attr_accessor :liquida_presentismo, :liquida_vacaciones, :liquida_aguinaldo

  after_initialize :inicializar

  validates :fecha, format: { with: /\A\d{4}-\d{2}-\d{2}\z/, message: 'Formato de fecha inválido' }
  validates :anios_antiguedad, numericality: { only_integer: true }

  def liquidar
    liquidar_antiguedad
    liquidar_presentismo
    liquidar_vacaciones
    liquidar_aguinaldo
    calcular_totales
  end

  private

  def inicializar
    if empleado && empleado.puesto
      self.puesto ||= empleado.puesto.descripcion
      self.basico ||= empleado.puesto.basico
    end
    self.anios_antiguedad     ||= 0
    self.antiguedad           ||= 0
    self.presentismo          ||= 0
    self.inasistencias        ||= 0
    self.dias_inasistencias   ||= 0
    self.vacaciones           ||= 0
    self.dias_vacaciones      ||= 0
    self.aguinaldo            ||= 0
    self.suma_no_remunerativa ||= 0
  end

  def liquidar_antiguedad
    self.antiguedad = self.basico * 0.01 * self.anios_antiguedad
  end

  def liquidar_presentismo
    if @liquida_presentismo
      self.presentismo = (self.basico + self.antiguedad) / 12
    else
      self.inasistencias = (self.basico + self.antiguedad) / 30 * self.dias_inasistencias
    end
  end

  def liquidar_vacaciones
    if @liquida_vacaciones
      self.vacaciones = (self.basico + self.antiguedad) / 25 * self.dias_vacaciones
      self.dias_inasistencias += self.dias_vacaciones
      self.inasistencias += (self.basico + self.antiguedad) / 30 * self.dias_vacaciones
    end
  end

  def liquidar_aguinaldo
    self.aguinaldo = remunerativo_antes_sac / 2 if @liquida_aguinaldo
  end

  def calcular_totales
    self.total_remunerativo = remunerativo_antes_sac + self.aguinaldo
    self.total_no_remunerativo = self.suma_no_remunerativa
    calcular_retenciones
    self.total_neto = self.total_remunerativo + self.total_no_remunerativo - self.total_descuentos
  end

  def calcular_retenciones
    self.jubilacion       = self.total_remunerativo * 0.11
    self.ley_pami         = self.total_remunerativo * 0.03
    self.obra_social      = self.total_remunerativo * 0.03
    self.cuota_sindical   = self.total_remunerativo * 0.025
    self.faecys           = self.total_remunerativo * 0.005
    self.total_descuentos = self.jubilacion + self.ley_pami + self.obra_social + self.cuota_sindical + self.faecys
  end

  def remunerativo_antes_sac
    self.basico + self.antiguedad + self.presentismo + self.vacaciones - self.inasistencias
  end
end
