class Empleado < ActiveRecord::Base
  belongs_to :localidad
  belongs_to :empresa
  has_many :liquidaciones

  def fecha_nacimiento_formatted
    fecha_nacimiento.strftime('%d/%m/%Y')
  end
end
