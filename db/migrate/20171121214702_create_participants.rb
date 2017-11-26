class CreateParticipants < ActiveRecord::Migration[5.0]
  def change
    create_table :participants do |t|
      t.integer :user_id
      t.integer :crease_id

      t.timestamps
    end
  end
end
