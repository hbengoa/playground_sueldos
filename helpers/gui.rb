# encoding: utf-8

class GUI
  BACKSPACE = "\177"

  def self.confirmacion_aceptada
    puts '¿Confirmar operacion? (s)'
    return STDIN.getch.downcase == 's'
  end

  def self.informar_usuario(msg)
    puts msg
    gets
  end

  def self.ask_input(etiqueta, valor_defecto)
    print "#{etiqueta}: [#{valor_defecto}] "
    input = gets.chomp
    input.blank? ? valor_defecto : input
  end

  def self.ask_confirmation
    print 'Presione <ENTER> para continuar..'
    gets
  end

  def self.confirma?(etiqueta)
    print "#{etiqueta}? s/n: "
    gets.chomp.downcase == 's'
  end
end
