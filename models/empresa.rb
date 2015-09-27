class Empresa < ActiveRecord::Base
  has_many :empleados
  belongs_to :localidad
end
