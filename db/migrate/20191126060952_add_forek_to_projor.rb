class AddForekToProjor < ActiveRecord::Migration[6.0]
  def change
    add_reference :projors, :forek, polymorphic: true, null: false
  end
end
