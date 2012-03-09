class CreateTipoClientes < ActiveRecord::Migration
  def change
    create_table :tipo_clientes do |t|
      t.string :tipo_cliente

      t.timestamps
    end
  end
end
