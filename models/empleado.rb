class Empleado < ActiveRecord::Base
  belongs_to :localidad
  belongs_to :empresa
  belongs_to :puesto
  has_many :recibos

  validates :nro_legajo, presence: true
  validates :nro_legajo, numericality: { only_integer: true }
  validates :fecha_nacimiento, format: { with: /\A\d{4}-\d{2}-\d{2}\z/, message: 'Formato de fecha inválido' }
  #validates :fecha_nacimiento, allow_nil: true
  validates :dni, format: { with: /\A\d?\d?\.?\d?\d?\d?\.?\d?\d?\d?\z/ }

  def fecha_nacimiento_formatted
    fecha_nacimiento.strftime('%d/%m/%Y')
  end
end
