class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :cidr
      t.timestamps
    end
  end
end
