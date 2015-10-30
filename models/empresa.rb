class Empresa < ActiveRecord::Base
  has_many :empleados
  has_many :recibos, through: :empleados
  belongs_to :localidad

  validates :cuit, format: { with: /\A\d{2}-\d{8}-\d\Z/, message: 'Formato de CUIT inválido' }
end
