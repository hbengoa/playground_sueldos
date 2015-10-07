class LiquidacionController
  def run
    loop do
      system("clear")
      load './views/liquidacion_menu_abm_view.rb'
      case STDIN.getch.downcase
        when 'l' then alta_liquidacion
        when GUI::BACKSPACE then return
        else
          GUI.informar_usuario 'Opción incorrecta!'
      end
    end
  end

  def alta_liquidacion
    EmpleadoController.listar_empleados
    if empleado = EmpleadoController.buscar_empleado
#      liquidacion = empleado.liquidaciones.build
    end
    gets
  end
end
