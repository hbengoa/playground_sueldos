class TotalesPorConceptoController
  def run
    system("clear")
    puts 'Totales por Concepto'
    desde_fecha = GUI.ask_input('Fecha desde', Date.today.beginning_of_month.to_s)
    hasta_fecha = GUI.ask_input('Fecha hasta', Date.today.end_of_month.to_s)
    report = TotalesPorConceptoReport.new($empresa_actual, desde_fecha, hasta_fecha)
    r = TotalesPorConceptoHelper.new(report)
    system("clear")
    ERB.new(File.read('views/totales_por_concepto.text.erb'), nil, '-').run(binding)
    GUI.ask_confirmation
  end
end
