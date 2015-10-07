class Detalle < ActiveRecord::Base
  belongs_to :liquidacion
  belongs_to :concepto
  self.table_name = 'detalles'
end
