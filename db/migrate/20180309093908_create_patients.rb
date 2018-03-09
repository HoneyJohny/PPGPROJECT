class CreatePatients < ActiveRecord::Migration[5.1]
  def change
    create_table :patients do |t|
      t.string :name
      t.integer :age
      t.integer :height
      t.integer :weight
      t.string :bloodgroup
      t.string :comment

      t.timestamps
    end
  end
end
