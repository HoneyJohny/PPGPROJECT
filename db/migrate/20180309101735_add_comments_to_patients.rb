class AddCommentsToPatients < ActiveRecord::Migration[5.1]
  def change
    add_column :patients, :comments, :string
  end
end
