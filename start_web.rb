#!/usr/bin/env ruby

require 'sinatra'
require_relative 'application'

Application.instance.db_connect

get '/empresas/index' do
  @empresas = Empresa.order(:razon_social)
  erb :empresa_index, layout: :app_layout
end

get '/empresas/new' do
  @empresas = Empresa.new
  @localidades = Localidad.order(:nombre)
  erb :empresa_new, layout: :app_layout
end

post '/empresas/create' do
  @empresa = Empresa.new(params)
  puts params
  if @empresa.save
    'empresa creado con exito'
  else
    @empresa.errors.full_messages
  end
end
