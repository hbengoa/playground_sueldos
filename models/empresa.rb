class Empresa < ActiveRecord::Base
  has_many :empleados
  has_many :recibos, through: :empleados
  belongs_to :localidad

  validates :razon_social, presence: true
  validates :razon_social, format: { with: /\A.{2,30}\z/, message: 'Tamaño de nombre inválido' }
  validates :razon_social, uniqueness: true
  validates :cuit, format: { with: /\A\d{2}-\d{8}-\d\Z/, message: 'Formato de CUIT inválido' }
  validates :cuit, uniqueness: true
  validates :domicilio, format: { with: /\A.{4,35}\z/, message: 'Tamaño de domicilio inválido' }
end
