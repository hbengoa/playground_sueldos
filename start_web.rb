#!/usr/bin/env ruby

require 'sinatra'
require "sinatra/reloader" if development?
require_relative 'application'

Application.instance.db_connect

get '/' do
  erb :home_view, layout: :app_layout
end

get '/empresas/index' do
  @empresas = Empresa.order(:razon_social)
  erb :empresa_index, layout: :app_layout
end

get '/empresas/new' do
  @empresa = Empresa.new
  @localidades = Localidad.order(:nombre)
  erb :empresa_form, layout: :app_layout
end

post '/empresas/create' do
  @empresa = Empresa.new(params[:empresa])
  if @empresa.save
    redirect to('/empresas/index')
  else
    @empresa.errors.full_messages
  end
end

get '/empresas/:id' do
  @empresa     = Empresa.find(params[:id])
  @localidades = Localidad.order(:nombre)
  erb :empresa_show, layout: :app_layout
end

put '/empresas/:id' do
  @empresa = Empresa.find(params[:id])
  if @empresa.update_attributes(params[:empresa])
    redirect to('/empresas/index')
  else
    @empresa.errors.full_messages
  end
end

delete '/empresas/:id' do
  @empresa = Empresa.find(params[:id])
  if @empresa.destroy
    redirect to('/empresas/index')
  else
    'No se puede eliminar'
  end
end

get '/empresas/:id/edit' do
  @empresa = Empresa.find(params[:id])
  @localidades = Localidad.order(:nombre)
  erb :empresa_form, layout: :app_layout
end

get '/seleccionar_empresa' do
  @empresas = Empresa.order(:razon_social)
  erb :seleccionar_empresa, layout: :app_layout
end

get '/empresas/:id/home' do
  @empresa = Empresa.find(params[:id])
  erb :empresa_home, layout: :app_layout
end
