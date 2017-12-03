class AddSlugToCreases < ActiveRecord::Migration[5.0]
  def change
    add_column :creases, :slug, :string, unique: true
  end
end
