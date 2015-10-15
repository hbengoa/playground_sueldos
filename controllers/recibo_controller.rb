class ReciboController
  def run
    loop do
      system("clear")
      load './views/recibo_menu_abm_view.rb'
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
      recibo = empleado.recibos.build
      system("clear")
      puts "A L T A   D E   N U E V A   L I Q U I D A C I O N\n"
      usuario_cargar_recibo(recibo)
    else
      GUI.informar_usuario('Empleado no encontrado')
    end
  end

  def usuario_cargar_recibo(recibo)
    recibo.fecha = GUI.ask_input('Fecha de recibo', Date.today.to_s)
    recibo.puesto = recibo.empleado.puesto.descripcion
    recibo.cargar_detalle
    recibo.save!
    recibo.mostrar
  end
end
