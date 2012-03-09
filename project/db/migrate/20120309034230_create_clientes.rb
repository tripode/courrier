class CreateClientes < ActiveRecord::Migration
  def change
    create_table :clientes do |t|
      t.string :email
      t.string :numero_telefono
      t.string :apellido
      t.integer :numero_identificacion
      t.string :nombre
      t.string :direccion
      t.string :ruc
      t.string :nombre_empresa

      t.timestamps
    end
  end
end
