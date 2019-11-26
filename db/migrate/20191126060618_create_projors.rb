class CreateProjors < ActiveRecord::Migration[6.0]
  def change
    create_table :projors do |t|
      t.integer :prof

      t.timestamps
    end
  end
end
