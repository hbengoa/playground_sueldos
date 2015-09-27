class EmpleadoController
  def initialize(empresa)
    @empresa_de_trabajo = empresa
    system("clear")
    puts "\n\t\t\t\t\t\t\tEmpresa de trabajo: #{empresa.razon_social}"
    load './views/abcml_empleado_menu_view.rb'
    x = STDIN.getch.downcase
    until x == 'a' or x == 'b' or x == 'l' or x == 'n' or x == 'l' or x == "\177" do
      x = STDIN.getch.downcase
    end
    system("clear")
    case x
    when 'a'                                                                                     # ALTA 
      @nueva_alta = Empleado.new
      puts 'A L T A   D E   N U E V O   E M P L E A D O'
      print 'Nro de Legajo: '
      @nueva_alta.nro_legajo = gets.chomp
      print 'Nombre y Apellido: '
      @nueva_alta.nombre_y_apellido = gets.chomp
      print 'Fecha de Nacimiento: '
      @nueva_alta.fecha_nacimiento = gets.chomp
      print 'DNI: '
      @nueva_alta.dni = gets.chomp
      printf "Localidades:\n"
      show_localidades
      printf "\nSeleccione ID de la localidad: "
      @nueva_alta.localidad_id = gets.chomp
      @nueva_alta.empresa_id = empresa.id
      puts "\nEl nro de legajo es #{@nueva_alta.nro_legajo}, el nombre es #{@nueva_alta.nombre_y_apellido}, "\
              "su fecha de nacimiento es #{@nueva_alta.fecha_nacimiento}, su dni es #{@nueva_alta.dni}, "\
              "su localidad es #{@nueva_alta.localidad.nombre}"
      puts "Si es correcto digite 's'"
      key = STDIN.getch.downcase
      @nueva_alta.save if key == 's'
    when 'b'
      show_empleados
      @nueva_baja = buscar_empleado
      if @nueva_baja
      puts "\nEl empleado se llama #{@nueva_baja.nombre_y_apellido}, su dni es #{@nueva_baja.dni}, "\
              "su ciudad es #{@nueva_baja.localidad.nombre} y su fecha de nac. es #{@nueva_baja.fecha_nacimiento}"\
              "\nPara darla de baja digite 's'" unless @nueva_baja == nil
      key = STDIN.getch.downcase
      @nueva_baja.destroy if key == 's'
      else
        puts 'Empleado inexistente'
        key = STDIN.getch.downcase
      end    
    when 'l'
      show_empleados
      print 'Seleccione legajo: '
      numero_leg = gets.chomp
      @empleado_de_trabajo = @empresa_de_trabajo.empleados.find_by(nro_legajo: numero_leg)
      puts "El empleado se llama #{@empleado_de_trabajo.nombre_y_apellido}"
      key = STDIN.getch
    end





  end

  private

    def show_empleados
      printf "\t\t\t\t\tL I S T A D O    D E   E M P L E A D O S\n\n\n"
      printf "NRO LEGAJO\tNOMBRE\t\t\t\tFECHA DE NAC.\t\t\DNI\t\tLOCALIDAD\n\n"
      @empresa_de_trabajo.empleados.each do |e|
        puts "#{e.nro_legajo}\t\t#{e.nombre_y_apellido}\t\t\t#{e.fecha_nacimiento}\t\t#{e.dni}\t#{e.localidad.nombre}"
      end
    end

    def show_localidades
      localidades = Localidad.all
      puts "ID\tNombre"
      localidades.each do |l|
        puts "#{l.id}\t#{l.nombre}"
      end
    end

    def buscar_empleado
      print 'Ingrese numero de legajo: '
      key = gets.chomp
      Empleado.find_by(nro_legajo: key)
    end
    
    

end
