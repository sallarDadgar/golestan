class CreateReshtehs < ActiveRecord::Migration[6.0]
  def change
    create_table :reshtehs do |t|
      t.string :title

      t.timestamps
    end
  end
end
