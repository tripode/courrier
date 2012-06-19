class HelpsController < ApplicationController
  
  def index
    @helps = [
      "Usuarios","Perfiles","Cambiar datos de la cuenta","Login","Logout",
      "Areas","Ciudades","Clientes","Clientes por empresa","Destinatarios","Empleados","Crear nota de retiro","Buscar notas de retiro",
              "Registrar producto","Buscar producto","Crear hoja de ruta","Buscar hoja de ruta","Cargar informe del repartidor",
              "Crear guia de transporte","Buscar guia de transporte","Crear manifiesto de carga","Listar manifiesto de carga"
    ]
  end
  
end
