class Liquidacion < ActiveRecord::Base
  belongs_to :empleado
  has_many :detalles
  self.table_name = 'liquidaciones'
end
