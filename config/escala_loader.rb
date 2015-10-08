class EscalaLoader
  def initialize(escala)
    puesto = nil
    categorias_y_brutos = {}

    f = File.open(File.expand_path("config/escala.txt"), "r")
    f.each_line do |line|
      case line.strip.to_sym
      when :administrativo
        escala[puesto] = categorias_y_brutos unless puesto.nil?
        puesto = :administrativo
        categorias_y_brutos = {}
      when :aux_especial
        escala[puesto] = categorias_y_brutos unless puesto.nil?
        puesto = :aux_especial
        categorias_y_brutos = {}
      when :auxiliar
        escala[puesto] = categorias_y_brutos unless puesto.nil?
        puesto = :auxiliar
        categorias_y_brutos = {}
      when :vendedor
        escala[puesto] = categorias_y_brutos unless puesto.nil?
        puesto = :vendedor
        categorias_y_brutos = {}
      when :maestranza
        escala[puesto] = categorias_y_brutos unless puesto.nil?
        puesto = :maestranza
        categorias_y_brutos = {}
      when :cajero
        escala[puesto] = categorias_y_brutos unless puesto.nil?
        puesto = :cajero
        categorias_y_brutos = {}
      else
        categoria, bruto = line.strip.split(/\s+/)
        categoria = categoria.to_sym
        bruto = bruto.to_f
        categorias_y_brutos[categoria] = bruto
      end
    end
  escala[puesto] = categorias_y_brutos
  f.close
  escala
  end
end
