class Puesto < ActiveRecord::Base
  has_many :empleados

  validates :basico, presence: true
  validates :basico, numericality: true
end
