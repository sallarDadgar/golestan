class AddFkToStuson < ActiveRecord::Migration[6.0]
  def change
    add_reference :stusons, :fk, polymorphic: true, null: false
  end
end
