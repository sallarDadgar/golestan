class CreateStusons < ActiveRecord::Migration[6.0]
  def change
    create_table :stusons do |t|
      t.integer :lesson
      t.string :mark

      t.timestamps
    end
  end
end
