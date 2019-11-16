class CreateProfs < ActiveRecord::Migration[6.0]
  def change
    create_table :profs do |t|
      t.string :college
      t.string :experience

      t.timestamps
    end
  end
end
