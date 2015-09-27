#!/usr/bin/env ruby

require 'io/console'
require_relative 'db/config'
require_relative 'controllers/main_controller'

MainController.new.run
