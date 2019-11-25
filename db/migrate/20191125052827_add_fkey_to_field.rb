class AddFkeyToField < ActiveRecord::Migration[6.0]
  def change
    add_reference :fields, :fkey, polymorphic: true, null: false
  end
end
