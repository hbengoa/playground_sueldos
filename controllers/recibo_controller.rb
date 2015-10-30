class ReciboController
  def run
    loop do
      system("clear")
      load './views/recibo_menu_abm_view.rb'
      case STDIN.getch.downcase
        when 'l' then alta
        when 'b' then baja
        when 'i' then listar_recibos
        when 'n' then TotalesPorConceptoController.new.run
        when GUI::BACKSPACE then return
        else
          GUI.informar_usuario 'Opción incorrecta!'
      end
    end
  end

  def alta
    EmpleadoController.listar_empleados
    if empleado = EmpleadoController.buscar_empleado
      recibo = empleado.recibos.build
      system("clear")
      puts "A L T A   D E   N U E V A   L I Q U I D A C I O N\n"
      ingresar_recibo(recibo)
      recibo.liquidar
      recibo.save!
      show(recibo)
    else
      GUI.informar_usuario('Empleado no encontrado')
    end
  end

  def listar_recibos
    system("clear")
    EmpleadoController.listar_empleados
    if empleado = EmpleadoController.buscar_empleado
      system("clear")
      recibos = empleado.recibos
      ERB.new(File.read('views/recibo_index_view.text.erb'), nil, '-').run(binding)
      GUI.ask_confirmation
    else
      GUI.informar_usuario 'Empleado inexistente'
    end
  end

  def baja
    system("clear")
    EmpleadoController.listar_empleados
    if empleado = EmpleadoController.buscar_empleado
      system("clear")
      recibos = empleado.recibos
      ERB.new(File.read('views/recibo_index_view.text.erb'), nil, '-').run(binding)
      if nueva_baja = seleccionar_recibo(empleado)
        if GUI.confirmacion_aceptada
          nueva_baja.destroy
          GUI.informar_usuario 'Recibo eliminado'
        end
      end
    else
      GUI.informar_usuario 'Empleado inexistente'
    end
  end

  def show(recibo)
    system("clear")
    r = recibo
    h = ReciboShowHelper.new(recibo)
    ERB.new(File.read('views/recibo_show_view.text.erb'), nil, '-').run(binding)
    GUI.ask_confirmation
  end

  private

  def ingresar_recibo(recibo)
    recibo.fecha                = GUI.ask_input('Fecha de recibo', Date.today.to_s)
    recibo.anios_antiguedad     = GUI.ask_input('Años antiguedad', '0')
    recibo.liquida_presentismo  = GUI.confirma?('Liquida presentismo')
    recibo.dias_inasistencias   = GUI.ask_input('Cantidad de dias de inasistencias', '1') unless recibo.liquida_presentismo
    recibo.suma_no_remunerativa = GUI.ask_input('Importe no remunerativo', '0') if GUI.confirma?('Liquida no remunrativo')
    recibo.liquida_vacaciones   = GUI.confirma?('Carga vacaciones')
    recibo.dias_vacaciones      = GUI.ask_input('Cantidad de dias de vacaciones', '14') if recibo.liquida_vacaciones
    recibo.liquida_aguinaldo    = GUI.confirma?('Liquida aguinaldo')
  end

  def seleccionar_recibo(empleado)
    print 'Ingrese id de recibo a eliminar: '
    Recibo.find_by(id: gets.chomp, empleado_id: empleado.id)
  end
end
