# ruby standard library #
require 'erb'
require 'singleton'
require 'io/console'

# firebird adapter #
require 'fb'

# rails dependencies #
require 'active_record'
require 'active_support'

# database connection #
require_relative 'db/config'

# application dependencies #
Dir['models/*.rb'].each        { |model|       require_relative model       }
Dir['reports/*.rb'].each       { |report|      require_relative report      }
Dir['controllers/*.rb'].each   { |controller|  require_relative controller  }
Dir['helpers/*.rb'].each       { |helper|      require_relative helper      }
Dir['views/helpers/*.rb'].each { |view_helper| require_relative view_helper }

class Application
  include Singleton

  attr_accessor :environment

  def initialize
    @environment = :production
  end

  def run
    db_connect
    MainController.new.run
  end

  def db_connect
    ActiveRecord::Base.establish_connection(environment)
  end
end
