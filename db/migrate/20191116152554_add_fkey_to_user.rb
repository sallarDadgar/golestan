class AddFkeyToUser < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :fkey, polymorphic: true, null: false
  end
end
