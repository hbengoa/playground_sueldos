class ConceptoController
  def initialize(x)
    until x == 'a' or x == 'b' or x == 'c' or x == 'm' or x == 'l' or x == "\177" do
      x = STDIN.getch.downcase
    end
    system("clear")
    case x
    when 'a'                                                                                     # ALTA 
      @nueva_alta = Concepto.new
      puts 'A L T A   D E   N U E V O   C O N C E P T O'
      print 'Codigo: '
      @nueva_alta.codigo = gets.chomp
      print 'Descripcion: '
      @nueva_alta.descripcion = gets.chomp
      puts "\nEl codigo es #{@nueva_alta.codigo}, el nombre es #{@nueva_alta.descripcion}"
      puts "Si es correcto digite 's'"
      key = STDIN.getch.downcase
      @nueva_alta.save if key == 's'
   when 'b'
      show_conceptos
      @nueva_baja = buscar_concepto
      if @nueva_baja
      puts "\nEl concepto se llama #{@nueva_baja.descripcion}, su codigo es #{@nueva_baja.codigo}"        
      puts "\nPara darla de baja digite 's'" unless @nueva_baja == nil
      key = STDIN.getch.downcase
      @nueva_baja.destroy if key == 's'
      else
        puts 'Concepto inexistente'
        key = STDIN.getch.downcase
      end    
    when 'l'
      show_conceptos
      z = STDIN.getch
    end





  end

  private

    def show_conceptos
      printf "\t\t\t\t\tL I S T A D O    D E   C O N C E P T O S\n\n\n"
      printf "CODIGO\tDESCRIPCION\n"
      conceptos = Concepto.all
      conceptos.each do |c|
        puts "#{c.codigo}\t#{c.descripcion}"
      end
    end

    def show_localidades
      localidades = Localidad.all
      puts "ID\tNombre"
      localidades.each do |l|
        puts "#{l.id}\t#{l.nombre}"
      end
    end

    def buscar_concepto
      print 'Ingrese codigo: '
      key = gets.chomp
      Concepto.find_by(codigo: key)
    end
    
    

end
