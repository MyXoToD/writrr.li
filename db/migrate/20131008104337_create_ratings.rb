class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :value
      t.references :users, index: true
      t.references :chapters, index: true

      t.timestamps
    end
  end
end
