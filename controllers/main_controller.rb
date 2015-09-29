# encoding: utf-8

require_relative 'empresa_controller'
require_relative 'concepto_controller'
require_relative '../helpers/gui'

class MainController
  def initialize
    @empresa_de_trabajo = Empresa.find_by(id: ultima_empresa_de_trabajo)
  end

  def run
    show_welcome
    main_loop
    terminate_app
  end

  private

  def show_welcome
    system("clear")
    load './views/welcome_view.rb'
    STDIN.getch
  end

  def main_loop
    system("clear")
    puts "\n\t\t\t\t\t\t\tEmpresa de trabajo: #{@empresa_de_trabajo.razon_social}"
    load './views/main_menu_view.rb'
    while (key = STDIN.getch.downcase) != GUI::BACKSPACE
      seleccionar_opcion_en_main_menu(key)
      system("clear")
      puts "\n\t\t\t\t\t\t\tEmpresa de trabajo: #{@empresa_de_trabajo.razon_social}"
      load './views/main_menu_view.rb'
    end
  end

  def terminate_app
    system("clear")
    puts 'Goodbye...!'
  end

  def ultima_empresa_de_trabajo
    File.open(File.expand_path("config/ultima_empresa.txt"), &:readline).chomp
  end

  def seleccionar_opcion_en_main_menu(x)
    case x
    when "e"
      EmpresaController.new.run
    when "c"
      system("clear")
      load './views/concepto_menu_abm_view.rb'
      key = STDIN.getch.downcase
      ConceptoController.new(key)
    when "m"
      EmpleadoController.new(@empresa_de_trabajo).run
    when "s"
      seleccionar_actual
    else
      puts 'Opcion incorrecta'
    end
  end

  def seleccionar_actual
    system("clear")
    EmpresaController.new.listar_empresas
    print "Seleccione Empresa de Trabajo: "
    id_seleccionado = gets.chomp
    empresa_actual = Empresa.find_by(id: id_seleccionado)
    if empresa_actual
      actualizar_ultima_empresa_de_trabajo(id_seleccionado)
      @empresa_de_trabajo = empresa_actual
    else
      puts "No existe empresa para ese id"
      gets
    end
  end

  def actualizar_ultima_empresa_de_trabajo(id)
    File.open(File.expand_path("config/ultima_empresa.txt"), "w") {|f| f.write(id) }
  end
end
