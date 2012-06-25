class HelpsController < ApplicationController
  
  def index
    @helps = [
      "Como crear Usuarios?","Manejo Perfiles","Como cambiar datos de la cuenta?","Login","Logout",
      "Como crear Areas?","Como cargar Ciudades?","Como crear Clientes por Persona?","Como crear Clientes por empresa?",
      "Como crear Destinatarios?","Como crear Empleados?","Como crear nota de retiro", "Buscar notas de retiro",
      "Como Registrar productos?","Buscar productos","Como Crear hoja de ruta?","Buscar hoja de ruta","Cargar informe del repartidor",
      "Como Crear guia de transporte?","Buscar guia de transporte",
      "Como Crear manifiesto de carga?","Listar manifiesto de carga"
    ]
  end
  
end
