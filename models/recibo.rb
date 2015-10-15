require_relative '../helpers/gui'

class Recibo < ActiveRecord::Base
  belongs_to :empleado
  self.table_name = 'recibos'

  def cargar_detalle
    carga_basico
    carga_antiguedad
    carga_presentismo
    carga_suma_no_remunerativa
    carga_vacaciones
    carga_aguinaldo
    calcula_totales_rem_y_no_rem
    calcula_descuentos
    calcula_total_neto
  end

  def mostrar
    system("clear")
    puts ERB.new(File.read('views/recibo_index_view.text.erb'), nil, '-').result(binding)
    GUI.ask_confirmation
  end

  private

  def carga_basico
    self.basico = empleado.puesto.basico
  end

  def carga_antiguedad
    self.anios_antiguedad = GUI.ask_input('Años antiguedad', '0')
    self.antiguedad = self.basico * 0.01 * self.anios_antiguedad
  end

  def carga_presentismo
    if GUI.liquida?('presentismo')
      self.presentismo = (self.basico + self.antiguedad) / 12
      self.inasistencias = BigDecimal("0")
      self.dias_inasistencias = 0
    else
      self.presentismo = BigDecimal("0")
      carga_inasistencias
    end
  end

  def carga_inasistencias
    self.dias_inasistencias = GUI.ask_input('Cantidad de dias de inasistencias', '1')
    self.inasistencias = (self.basico + self.antiguedad) / 30 * self.dias_inasistencias
  end

  def carga_suma_no_remunerativa
    GUI.liquida?('suma_no_remunerativa') ? self.suma_no_remunerativa = BigDecimal.new("1524") : self.suma_no_remunerativa = BigDecimal.new("0")
  end

  def carga_vacaciones
    if GUI.liquida?('vacaciones')
      self.dias_vacaciones = GUI.ask_input('Cantidad de dias de vacaciones', '14')
      self.vacaciones = (self.basico + self.antiguedad) / 25 * self.dias_vacaciones
      self.dias_inasistencias += self.dias_vacaciones
      self.inasistencias += (self.basico + self.antiguedad) / 30 * self.dias_vacaciones
    else
      self.dias_vacaciones = 0
      self.vacaciones = BigDecimal("0")
    end
  end

  def carga_aguinaldo
    @rem_antes_de_sac = self.basico + self.antiguedad + self.presentismo + self.vacaciones - self.inasistencias
    GUI.liquida?('aguinaldo') ? self.aguinaldo = @rem_antes_de_sac / 2 : self.aguinaldo = BigDecimal("0")
  end

  def calcula_totales_rem_y_no_rem
    self.total_remunerativo = @rem_antes_de_sac + self.aguinaldo
    self.total_no_remunerativo = self.suma_no_remunerativa
  end

  def calcula_descuentos
    self.jubilacion = self.total_remunerativo * 0.11
    self.ley_pami = self.total_remunerativo * 0.03
    self.obra_social = self.total_remunerativo * 0.03
    self.cuota_sindical = self.total_remunerativo * 0.025
    self.faecys = self.total_remunerativo * 0.005
    self.total_descuentos = self.jubilacion + self.ley_pami + self.obra_social + self.cuota_sindical + self.faecys
  end

  def calcula_total_neto
    self.total_neto = self.total_remunerativo + self.total_no_remunerativo - self.total_descuentos
  end
end
