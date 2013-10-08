class CreateChapters < ActiveRecord::Migration
  def change
    create_table :chapters do |t|
      t.string :title
      t.text :content
      t.references :stories, index: true

      t.timestamps
    end
  end
end
