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
#    cargar_novedades
#    totalizar
#    confirmar y salvar
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
 #  calcular_presentismo(liquidacion)
 #  calcular_suma_no_remunerativa(liquidacion)
  end

  def calcular_basico(liquidacion, escala)
    detalle = liquidacion.detalles.build
    detalle.concepto_id = Concepto.find_by(codigo: 1000).id
    detalle.importe = BigDecimal.new(escala[liquidacion.puesto.to_sym][liquidacion.categoria.to_sym].to_s)
    detalle.save!
    return detalle.importe
  end

  def calcular_antiguedad(liquidacion, basico)
    anios_antiguedad = GUI.ask_input('Antiguedad en años', 0)
    detalle = liquidacion.detalles.build
    detalle.concepto_id = Concepto.find_by(codigo: 1001).id
    detalle.importe = basico * BigDecimal.new(anios_antiguedad) / 100
    detalle.save!
    return detalle.importe
  end
end
