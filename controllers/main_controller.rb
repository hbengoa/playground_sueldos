# encoding: utf-8

require_relative 'empresa_controller'
require_relative 'empleado_controller'
require_relative 'localidad_controller'
require_relative 'recibo_controller'
require_relative 'puesto_controller'
require_relative '../helpers/gui'

class MainController
  def initialize
    $empresa_actual = Empresa.find_by(id: ultima_empresa_de_trabajo)
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
    load './views/main_menu_view.rb'
    while (key = STDIN.getch.downcase) != GUI::BACKSPACE
      seleccionar_opcion_en_main_menu(key)
      system("clear")
      load './views/main_menu_view.rb'
    end
  end

  def terminate_app
    system("clear")
    puts 'Goodbye...!'
  end

  def seleccionar_opcion_en_main_menu(x)
    case x
    when "s"
      seleccionar_actual
    when "e"
      EmpresaController.new.run
    when "m"
      EmpleadoController.new.run
    when "o"
      LocalidadController.new.run
    when "i"
      ReciboController.new.run
    else
      puts 'Opcion incorrecta'
    end
  end

  def seleccionar_actual
    system("clear")
    EmpresaController.listar_empresas
    print "Seleccione Empresa de Trabajo: "
    empresa_seleccionada = Empresa.find_by(id: gets.chomp)
    if empresa_seleccionada
      $empresa_actual = empresa_seleccionada
      actualizar_ultima_empresa_de_trabajo($empresa_actual.id)
    else
      puts "No existe empresa para ese id"
      gets
    end
  end

  def ultima_empresa_de_trabajo
    File.open(File.expand_path("config/ultima_empresa.txt"), &:readline).chomp
  end

  def actualizar_ultima_empresa_de_trabajo(id)
    File.open(File.expand_path("config/ultima_empresa.txt"), "w") {|f| f.write(id) }
  end
end
