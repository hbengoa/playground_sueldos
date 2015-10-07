class Empleado < ActiveRecord::Base
  belongs_to :localidad
  belongs_to :empresa
  has_many :liquidaciones
end
