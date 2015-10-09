class Detalle < ActiveRecord::Base
  belongs_to :liquidacion
  belongs_to :concepto
  self.table_name = 'detalles'

  def remunerativo?
    (1000..2999).include?(self.concepto.codigo)
  end

  def basico?
    concepto_id == 1
  end
end
