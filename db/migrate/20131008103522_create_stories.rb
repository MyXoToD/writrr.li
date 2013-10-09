class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :title
      t.text :teaser
      t.string :genre
      t.references :user, index: true

      t.timestamps
    end
  end
end
