class AddCreatorIdToCreases < ActiveRecord::Migration[5.0]
  def change
    add_column :creases, :creator_id, :integer
  end
end
