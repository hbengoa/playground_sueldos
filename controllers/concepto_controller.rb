class ConceptoController
  def run
    loop do
      system("clear")
      load './views/concepto_menu_abm_view.rb'
      case STDIN.getch.downcase
        when 'a' then alta
        when 'b' then baja
        when 'm' then modificacion
        when 'u' then buscar_por_descripcion
        when 'l' then ConceptoController.listar_conceptos
        when GUI::BACKSPACE then return
        else
          GUI.informar_usuario 'Opción incorrecta!'
      end
    end
  end

  def self.listar_conceptos
    system("clear")
    printf "\t\t\t\t\tL I S T A D O    D E   C O N C E P T O S\n\n\n"
    printf "CODIGO\tDESCRIPCION\n"
    Concepto.all.order(:codigo).each do |c|
      puts "#{c.codigo}\t#{c.descripcion}"
    end
    gets
  end

  private

  def alta
    concepto = Concepto.new
    system("clear")
    puts 'A L T A   D E   N U E V O   C O N C E P T O'
    usuario_cargar_concepto(concepto)
    if GUI.confirmacion_aceptada
     concepto.save!
      GUI.informar_usuario 'Concepto dado de alta'
    end
  end

  def baja
    system("clear")
    puts "C O N C E P T O   A   D A R   D E   B A J A"
    ConceptoController.listar_conceptos
    if nueva_baja = buscar_concepto
      if GUI.confirmacion_aceptada
        nueva_baja.destroy
        GUI.informar_usuario 'Concepto eliminado'
      end
    else
      GUI.informar_usuario 'Concepto inexistente'
    end
  end

  def modificacion
    system("clear")
    ConceptoController.listar_conceptos
    printf "Concepto a modificar\n"
    if concepto = buscar_concepto
      usuario_cargar_concepto(concepto)
      if GUI.confirmacion_aceptada
        concepto.save!
        GUI.informar_usuario 'Concepto actualizado'
      end
    else
      GUI.informar_usuario 'Concepto inexistente'
    end
  end

  def usuario_cargar_concepto(concepto)
    concepto.codigo = GUI.ask_input('Codigo', concepto.codigo)
    concepto.descripcion = GUI.ask_input('Descripcion', concepto.descripcion)
  end

  def buscar_concepto
    print 'Ingrese codigo: '
    key = gets.chomp
    Concepto.find_by(codigo: key)
  end

  def buscar_por_descripcion
  end
end
