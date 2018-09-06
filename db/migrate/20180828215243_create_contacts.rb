class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
      t.integer :company_id
      t.string :email
      t.timestamps
    end
  end
end
