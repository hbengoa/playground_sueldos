require_relative '../config/escala_loader'

class LiquidacionController
  def run
    loop do
      system("clear")
      load './views/liquidacion_menu_abm_view.rb'
      case STDIN.getch.downcase
        when 'l' then alta
        when GUI::BACKSPACE then return
        else
          GUI.informar_usuario 'Opción incorrecta!'
      end
    end
  end

  private

  def alta
    EmpleadoController.listar_empleados
    if empleado = EmpleadoController.buscar_empleado
      liquidacion = empleado.liquidaciones.build
      system("clear")
      puts "A L T A   D E   N U E V A   L I Q U I D A C I O N\n"
      usuario_cargar_liquidacion(liquidacion)
    else
      GUI.informar_usuario('Empleado no encontrado')
    end
  end

  def usuario_cargar_liquidacion(liquidacion)
    liquidacion.fecha = GUI.ask_input('Fecha de liquidacion', Date.today.to_s)
    escala = {}
    EscalaLoader.new(escala)
    puts "#{liquidacion.puesto = seleccionar_puesto(escala)}"
    puts "#{liquidacion.categoria = seleccionar_categoria(escala, liquidacion.puesto)} "
    cargar_conceptos_fijos(liquidacion, escala)
    cargar_novedades(liquidacion)
    liquidacion.calcular_totales
#    confirmar y salvar
    liquidacion.save!
  end

  def seleccionar_puesto(escala)
    puts 'PUESTO DE TRABAJO'
    escala.keys.each_with_index do |puesto, index|
       puts "#{index + 1}. #{puesto}"
    end
    print 'Seleccione: '
    case STDIN.getch.downcase
      when '1' then 'maestranza'
      when '2' then 'auxiliar'
      when '3' then 'aux_especial'
      when '4' then 'administrativo'
      when '5' then 'vendedor'
      when '6' then 'cajero'
      when GUI::BACKSPACE then return
      else
        GUI.informar_usuario 'Opción incorrecta!'
    end
  end

  def seleccionar_categoria(escala, puesto)
    puts "CATEGORIA DE #{puesto.upcase}"
    print 'Seleccione: '
    escala[puesto.to_sym].keys.each do |categoria|
      print "#{categoria}    "
    end
    case STDIN.getch.downcase
      when 'a' then 'A'
      when 'b' then 'B'
      when 'c' then 'C'
      when 'd' then 'D'
      when GUI::BACKSPACE then return
      else
        GUI.informar_usuario 'Opcion incorrecta!'
    end
  end

  def cargar_conceptos_fijos(liquidacion, escala)
    system("clear")
    puts "C a r g a   d e   C o n c e p t o s"
    basico = calcular_basico(liquidacion, escala)
    antiguedad = calcular_antiguedad(liquidacion, basico)
    calcular_presentismo(liquidacion, basico + antiguedad)
    calcular_suma_no_remunerativa(liquidacion)
  end

  def calcular_basico(liquidacion, escala)
    detalle = liquidacion.detalles.build
    detalle.concepto_id = Concepto.find_by(codigo: 1000).id
    detalle.importe = BigDecimal.new(escala[liquidacion.puesto.to_sym][liquidacion.categoria.to_sym].to_s)
    return detalle.importe
  end

  def calcular_antiguedad(liquidacion, basico)
    anios_antiguedad = GUI.ask_input('Antiguedad en años', "0")
    if BigDecimal.new(anios_antiguedad) > 0
      detalle = liquidacion.detalles.build
      detalle.concepto_id = Concepto.find_by(codigo: 1001).id
      detalle.importe = basico * BigDecimal.new(anios_antiguedad) / 100
      return detalle.importe
    else
      return BigDecimal.new("0")
    end
  end

  def calcular_presentismo(liquidacion, acumulado)
    liquida = GUI.ask_input('Liquida presentismo? s/n: ', "s")
    if liquida.downcase == "s"
      detalle = liquidacion.detalles.build
      detalle.concepto_id = Concepto.find_by(codigo: 1002).id
      detalle.importe = acumulado / 12
    end
  end

  def calcular_suma_no_remunerativa(liquidacion)
    liquida = GUI.ask_input('Liquida suma no remunerativa? s/n: ', "s")
    if liquida.downcase == "s"
      detalle = liquidacion.detalles.build
      detalle.concepto_id = Concepto.find_by(codigo: 3000).id
      detalle.importe = BigDecimal.new("1524")
    end
  end

  def cargar_novedades(liquidacion)
    bruto = bruto_acumulado(liquidacion)
    conceptos_nov = Concepto.where("codigo >= 2000 and codigo <= 2999").order(:codigo)
    conceptos_nov.each do |concepto|
      case concepto.codigo
        when 2000 then calcula_inasist_injustificada(liquidacion, bruto)
        when 2001 then calcula_inasist_justificada(liquidacion, bruto)
        when 2002 then calcula_lic_enfermedad(liquidacion)
        when 2998 then calcula_vacaciones(liquidacion, bruto)
        when 2999 then calcula_aguinaldo(liquidacion, bruto)
      end
    end
  end

  def bruto_acumulado(liquidacion)
    bruto = BigDecimal.new("0")
    liquidacion.detalles.each do |con|
      bruto += con.importe if Concepto.find_by(id: con.concepto_id).codigo <= 1999
    end
    bruto
  end

  def calcula_inasist_injustificada(liquidacion, bruto)
    if liquidacion.detalles.where(concepto_id: 3).empty?
      dias_cant = BigDecimal.new(GUI.ask_input('Dias inasistencia injustificada: ', '0'))
      if dias_cant > 0
        detalle = liquidacion.detalles.build
        detalle.concepto_id = Concepto.find_by(codigo: 2000).id
        detalle.importe = bruto / 30 * dias_cant
      end
    end
  end

  def calcula_inasist_justificada(liquidacion, bruto)
    if liquidacion.detalles.where(concepto_id: 3).empty?
      dias_cant = BigDecimal.new(GUI.ask_input('Dias inasistencia justificada: ', '0'))
      if dias_cant > 0
        detalle = liquidacion.detalles.build
        detalle.concepto_id = Concepto.find_by(codigo: 2001).id
        detalle.importe = bruto / 30 * dias_cant
      end
    end
  end

  def calcula_lic_enfermedad(liquidacion)
    if GUI.ask_input('Liquida licencia por enfermedad? s/n: ', "s").downcase == "s"
      detalle = liquidacion.detalles.build
      detalle.concepto_id = Concepto.find_by(codigo: 2002).id
      detalle.importe = BigDecimal.new(gets.chomp)
    end
  end

  def calcula_vacaciones(liquidacion, bruto)
    if liquidacion.detalles.where(concepto_id: 3).empty?
      dias_vac_cant = BigDecimal.new(GUI.ask_input('Dias de vacaciones: ', '0'))
      if dias_vac_cant > 0
        detalle = liquidacion.detalles.build
        detalle.concepto_id = Concepto.find_by(codigo: 2998).id
        detalle.importe = bruto / 25 * dias_vac_cant
      end
    end
  end

  def calcula_aguinaldo(liquidacion, bruto)
    liquida = GUI.ask_input('Liquida aguinaldo? s/n: ', "s")
    if liquida.downcase == "s"
      detalle = liquidacion.detalles.build
      detalle.concepto_id = Concepto.find_by(codigo: 2999).id
      detalle.importe = bruto / 2
    end
  end
end
