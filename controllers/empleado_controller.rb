class EmpleadoController
  def run
    loop do
      system("clear")
      load './views/empleado_menu_abm_view.rb'
      case STDIN.getch.downcase
        when 'a' then alta
        when 'b' then baja
        when 'l' then EmpleadoController.listar_empleados
        when GUI::BACKSPACE then return
        else
          GUI.informar_usuario 'Opción incorrecta!'
      end
    end
  end

  def self.listar_empleados
    system("clear")
    $empresa_actual.reload
    ERB.new(File.read('views/empleado_index_view.text.erb'), nil, '-').run
    GUI.ask_confirmation
  end

  def self.buscar_empleado
    print 'Ingrese numero de legajo: '
    Empleado.find_by(empresa_id: $empresa_actual.id, nro_legajo: gets.chomp)
  end

  private

  def alta
    empleado = $empresa_actual.empleados.build
    system("clear")
    puts 'A L T A   D E   N U E V O   E M P L E A D O'
    usuario_cargar_empleado(empleado)
    if GUI.confirmacion_aceptada
      empleado.save!
      GUI.informar_usuario 'Empleado dada de alta'
    end
  end

  def baja
    EmpleadoController.listar_empleados
    puts "E M P L E A D O   A   D A R   D E   B A J A"
    if nueva_baja = EmpleadoController.buscar_empleado
      if GUI.confirmacion_aceptada
        nueva_baja.destroy
        GUI.informar_usuario 'Empleado eliminado'
      end
    else
      GUI.informar_usuario 'Empleado inexistente'
    end
  end

  def usuario_cargar_empleado(empleado)
    empleado.nro_legajo = GUI.ask_input('Nro de Legajo: ', empleado.nro_legajo)
    empleado.nombre_y_apellido = GUI.ask_input('Nombre y Apellido: ', empleado.nombre_y_apellido)
    empleado.fecha_nacimiento = GUI.ask_input('Fecha de nacimiento: ', empleado.fecha_nacimiento)
    empleado.dni = GUI.ask_input('DNI: ', empleado.dni)
    LocalidadController.listar_localidades
    empleado.localidad_id = GUI.ask_input('Id localidad: ', empleado.localidad_id)
  end
end
