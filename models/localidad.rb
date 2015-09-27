class Localidad < ActiveRecord::Base
  has_many :empresas
  has_many :empleados
  self.table_name = 'localidades'
end
