class PuestoController
  def self.listar_puestos
    system("clear")
    printf "\t\t\t\t\tL I S T A D O    D E   P U E S T O S\n\n\n"
    printf "ID\tDESCRIPCION\n\n"
    Puesto.all.each do |p|
      puts "#{p.id}\t#{p.descripcion}"
    end
    GUI.ask_confirmation
  end
end
