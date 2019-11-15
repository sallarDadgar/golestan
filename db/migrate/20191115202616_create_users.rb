class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :frst_name
      t.string :last_name
      t.string :email
      t.string :code
      t.integer :role
      t.string :profile

      t.timestamps
    end
  end
end
