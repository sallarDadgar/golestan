class CreateAdmins < ActiveRecord::Migration[6.0]
  def change
    create_table :admins do |t|
      t.string :age
      t.string :nationality

      t.timestamps
    end
  end
end
