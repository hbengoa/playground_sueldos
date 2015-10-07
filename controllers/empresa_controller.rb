# encoding: utf-8
require_relative 'empleado_controller'

class EmpresaController
  def run
    loop do
      system("clear")
      load './views/empresa_menu_abm_view.rb'
      case STDIN.getch.downcase
        when 'a' then alta
        when 'b' then baja
        when 'm' then modificacion
        when 'u' then buscar_por_razon_social
        when 'l' then EmpresaController.listar_empresas
        when GUI::BACKSPACE then return
        else
          GUI.informar_usuario 'Opción incorrecta!'
      end
    end
  end

  def self.listar_empresas
    system("clear")
    printf "\t\t\t\t\tL I S T A D O    D E   E M P R E S A S\n\n\n"
    printf "ID\tNOMBRE\t\t\t\tCUIT\t\t\tDOMICILIO\t\t\tLOCALIDAD\n\n"
    Empresa.order(:razon_social).each do |e|
      puts "#{e.id}\t#{e.razon_social}\t\t\t#{e.cuit}\t\t#{e.domicilio}\t\t\t#{e.localidad.nombre}"
    end
    gets
  end

  def self.show_empresa_actual
    puts "\n\n\n\t\tEMPRESA DE TRABAJO: #{$empresa_actual.razon_social}"
  end

  private

  def alta
    empresa = Empresa.new
    system("clear")
    puts 'A L T A   D E   N U E V A   E M P R E S A'
    usuario_cargar_empresa(empresa)
    if GUI.confirmacion_aceptada
      empresa.save!
      GUI.informar_usuario 'Empresa dada de alta'
    end
  end

  def baja
    system("clear")
    puts "E M P R E S A   A   D A R   D E   B A J A"
    EmpresaController.listar_empresas
    if nueva_baja = buscar_empresa
      if GUI.confirmacion_aceptada
        nueva_baja.destroy
        GUI.informar_usuario 'Empresa eliminada'
      end
    else
      GUI.informar_usuario 'Empresa inexistente'
    end
  end

  def modificacion
    system("clear")
    EmpresaController.listar_empresas
    printf "Empresa a modificar\n"
    if empresa = buscar_empresa
      usuario_cargar_empresa(empresa)
      if GUI.confirmacion_aceptada
        empresa.save!
        GUI.informar_usuario 'Empresa actualizada'
      end
    else
      GUI.informar_usuario 'Empresa inexistente'
    end
  end

  def usuario_cargar_empresa(empresa)
    empresa.razon_social = GUI.ask_input('Razón Social', empresa.razon_social)
    empresa.cuit = GUI.ask_input('CUIT', empresa.cuit)
    empresa.domicilio = GUI.ask_input('Domicilio', empresa.domicilio)
    LocalidadController.listar_localidades
    empresa.localidad_id = GUI.ask_input('Id localidad: ', empresa.localidad_id)
  end

  def buscar_por_razon_social
    system("clear")
    print "Razon social: "
    empresas_encontradas = Empresa.where("lower(razon_social) like ?", "%#{gets.chomp.downcase}%")
    show_resultados_busqueda(empresas_encontradas) if empresas_encontradas.any?
    gets
  end

  def show_resultados_busqueda(empresas)
    printf "\n\t\t\t\t\tL I S T A D O    D E   E M P R E S A S   E N C O N T R A D A S\n\n\n"
    printf "ID\tNOMBRE\t\t\t\tCUIT\t\t\tDOMICILIO\t\t\tLOCALIDAD\n\n"
    empresas.order(:razon_social).each do |e|
      puts "#{e.id}\t#{e.razon_social}\t\t\t#{e.cuit}\t\t#{e.domicilio}\t\t\t#{e.localidad.nombre}"
    end
    gets
  end

  def buscar_empresa
    print 'Ingrese id: '
    Empresa.find_by(id: gets.chomp)
  end
end
