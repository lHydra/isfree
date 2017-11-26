class CreateCreases < ActiveRecord::Migration[5.0]
  def change
    create_table :creases do |t|
      t.string :title
      t.string :link
      t.text :description
      t.integer :quantity, default: 0
      t.integer :recommended_quantity
      t.integer :amount

      t.timestamps
    end
  end
end
