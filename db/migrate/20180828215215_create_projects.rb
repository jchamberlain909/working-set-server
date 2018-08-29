class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.integer :company_id
      t.string :name
      t.timestamps
    end
  end
end
