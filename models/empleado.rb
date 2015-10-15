class Empleado < ActiveRecord::Base
  belongs_to :localidad
  belongs_to :empresa
  belongs_to :puesto
  has_many :recibos

  def fecha_nacimiento_formatted
    fecha_nacimiento.strftime('%d/%m/%Y')
  end
end
