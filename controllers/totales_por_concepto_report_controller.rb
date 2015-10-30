require_relative '../reports/totales_por_concepto_report'

class TotalesPorConceptoReportController
  def run
    system("clear")
    puts 'Totales por Concepto'
    desde_fecha = GUI.ask_input('Fecha desde', Date.today.beginning_of_month.to_s)
    hasta_fecha = GUI.ask_input('Fecha hasta', Date.today.end_of_month.to_s)
    recibos = seleccionar_recibos(desde_fecha, hasta_fecha)
    i = TotalesPorConceptoReport.new(recibos).generar
    system("clear")
    puts i.antiguedad
    gets
#    ERB.new(File.read('views/totales_por_concepto.text.erb'), nil, '-').run(binding)
    GUI.ask_confirmation
  end

  def seleccionar_recibos(desde_fecha, hasta_fecha)
    recibos = []
    $empresa_actual.empleados.each do |e|
      e.recibos.each do |r|
        recibos << r if desde_fecha <= r.fecha.to_s and r.fecha.to_s <= hasta_fecha
      end
    end
    recibos
  end
end
