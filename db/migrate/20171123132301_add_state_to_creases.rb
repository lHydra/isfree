class AddStateToCreases < ActiveRecord::Migration[5.0]
  def change
    add_column :creases, :state, :string
  end
end
