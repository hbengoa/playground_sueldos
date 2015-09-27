require 'active_record'
require 'fb'

require_relative '../models/empresa'
require_relative '../models/empleado'
require_relative '../models/concepto'
require_relative '../models/concepto_personal'
require_relative '../models/localidad'


config = { 'sueldos' => { 'adapter' => 'fb',
                          'database' => 'db/sueldos.fdb',
                          'username' => 'sysdba',
                          'password' => 'masterkey',
                          'host' => 'localhost',
                          'create' => true,
                          'encoding' => 'UTF-8' } }

ActiveRecord::Base.configurations = config
ActiveRecord::Base.establish_connection(:sueldos)
