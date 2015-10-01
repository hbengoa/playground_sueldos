# encoding: utf-8

class LocalidadController
  def run
    loop do
      system("clear")
      load './views/localidad_menu_abm_view.rb'
      case STDIN.getch.downcase
        when 'a' then alta
        when 'b' then baja
        when 'm' then modificacion
        when 'l' then LocalidadController.listar_localidades
        when GUI::BACKSPACE then return
        else
          GUI.informar_usuario 'Opción incorrecta!'
      end
    end
  end

  def self.listar_localidades
    system("clear")
    localidades = Localidad.all
    puts "ID\tNombre de localidad"
    localidades.each do |l|
      puts "#{l.id}\t#{l.nombre}"
    end
    gets
  end

  private

  def alta
    localidad = Localidad.new
    system("clear")
    puts 'A L T A   D E   N U E V A   L O C A L I D A D'
    usuario_cargar_localidad(localidad)
    if GUI.confirmacion_aceptada
      localidad.save!
      GUI.informar_usuario 'Localidad dada de alta'
    end
  end

  def baja
    puts "L O C A L I D A D   A   D A R   D E   B A J A"
    LocalidadController.listar_localidades
    if nueva_baja = buscar_localidad
      if GUI.confirmacion_aceptada
        nueva_baja.destroy
        GUI.informar_usuario 'Localidad eliminada'
      end
    else
      GUI.informar_usuario 'Localidad inexistente'
    end
  end

  def modificacion
    system("clear")
    LocalidadController.listar_localidades
    printf "Localidad a modificar\n"
    if localidad = buscar_localidad
      usuario_cargar_localidad(localidad)
      if GUI.confirmacion_aceptada
        localidad.save!
        GUI.informar_usuario 'Localidad actualizada'
      end
    else
      GUI.informar_usuario 'Localidad inexistente'
    end
  end

  def usuario_cargar_localidad(localidad)
    localidad.nombre = GUI.ask_input('Nombre: ', localidad.nombre)
  end

  def buscar_localidad
    print 'Ingrese id: '
    Localidad.find_by(id: gets.chomp)
  end
end
