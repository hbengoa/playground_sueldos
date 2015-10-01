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
    printf "\t\t\t\t\tL I S T A D O    D E   E M P L E A D O S\n\n\n"
    printf "NRO LEGAJO\tNOMBRE\t\t\t\tFECHA DE NAC.\t\t\DNI\t\tLOCALIDAD\n\n"
    empleados = $empresa_actual.empleados
    empleados.each do |e|
      puts "#{e.nro_legajo}\t\t#{e.nombre_y_apellido}\t\t\t#{e.fecha_nacimiento}\t\t#{e.dni}\t#{e.localidad.nombre}"
    end
    gets
  end

  private

  def alta
    empleado = Empleado.new
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
    if nueva_baja = buscar_empleado
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
    empleado.empresa_id = $empresa_actual.id
  end

  def buscar_empleado
    print 'Ingrese numero de legajo: '
    Empleado.find_by(empresa_id: $empresa_actual.id, nro_legajo: gets.chomp)
  end
end
