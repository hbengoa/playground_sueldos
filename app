#!/usr/bin/env ruby

system("clear")
load './db/config.db'		# establece conexion con la base de datos
load './views/welcome_view.rb'  # muesta pantalla de bienvenida
require 'io/console'
key = STDIN.getch

Main.new.run
