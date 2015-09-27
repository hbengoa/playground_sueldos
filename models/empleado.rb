class Empleado < ActiveRecord::Base
  belongs_to :localidad
  belongs_to :empresa
end
