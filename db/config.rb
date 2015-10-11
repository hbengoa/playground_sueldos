require 'active_record'
require 'fb'
require 'pry-byebug'
require 'erb'

require_relative '../models/empresa'
require_relative '../models/empleado'
require_relative '../models/concepto'
require_relative '../models/localidad'
require_relative '../models/liquidacion'
require_relative '../models/detalle'

ActiveSupport::Inflector.inflections do |inflect|
  inflect.irregular 'liquidacion', 'liquidaciones'
end

config = { 'sueldos' => { 'adapter' => 'fb',
                          'database' => 'db/sueldos.fdb',
                          'username' => 'sysdba',
                          'password' => 'masterkey',
                          'host' => 'localhost',
                          'create' => true,
                          'encoding' => 'UTF-8' } }

ActiveRecord::Base.configurations = config
ActiveRecord::Base.establish_connection(:sueldos)
