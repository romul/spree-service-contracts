class CreateServiceContracts < ActiveRecord::Migration
  def self.up
    create_table :service_contracts do |t|
      t.string :name
      t.decimal :price, :precision => 8, :scale => 2, :null => false
      t.timestamps
    end
    
    create_table :products_service_contracts, :id => false do |t|
      t.integer :product_id
      t.integer :service_contract_id
    end
  end

  def self.down
    drop_table :products_service_contracts
    drop_table :service_contracts
  end
end
