# encoding: utf-8

require_relative 'empresa_controller'
require_relative 'concepto_controller'
require_relative '../helpers/gui'

class MainController
  def run
    show_welcome
    main_loop
    terminate_app
  end

  private

  def show_welcome
    system("clear")
    load './views/welcome_view.rb'
    gets
    system("clear")
    load './views/main_menu_view.rb'
  end

  def main_loop
    while (key = STDIN.getch.downcase) != GUI::BACKSPACE do
      select_option_in_main_menu(key)
      system("clear")
      load './views/main_menu_view.rb'
    end
  end

  def terminate_app
    system("clear")
    puts 'Goodbye...!'
  end

  def select_option_in_main_menu(x)
    case x
    when "e"
      EmpresaController.new.run
    when "c"
      system("clear")
      load './views/concepto_menu_abm_view.rb'
      key = STDIN.getch.downcase
      ConceptoController.new(key)
    when "l"
      puts 'eligio localidad'
    else
      puts 'Opcion incorrecta!'
      gets
    end
  end

  def seleccionar_actual
    system("clear")
    listar
    print "Seleccione Empresa de Trabajo: "
    ident = gets.chomp
    empresa_actual = Empresa.find_by(id: ident)
    if empresa_actual
      EmpleadoController.new(empresa_actual)
    else
      puts "No existe empresa para ese id"
      STDIN.getch
    end
  end
end
