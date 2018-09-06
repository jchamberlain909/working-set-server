class CreateFollows < ActiveRecord::Migration[5.2]
  def change
    create_table :follows do |t|
      t.integer :contact_id
      t.integer :project_id
      t.string :status
      t.timestamps
    end
  end
end
