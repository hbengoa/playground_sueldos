class Liquidacion < ActiveRecord::Base
  belongs_to :empleado
  has_many :detalles
  self.table_name = 'liquidaciones'

  def calcular_totales
    self.total_remunerativo = detalles.select { |d| d.remunerativo? }.map { |d| d.importe }.inject(BigDecimal(0), &:+)
  end
end
