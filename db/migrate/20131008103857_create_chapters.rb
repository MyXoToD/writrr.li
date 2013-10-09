class CreateChapters < ActiveRecord::Migration
  def change
    create_table :chapters do |t|
      t.string :title
      t.text :content
      t.references :story, index: true

      t.timestamps
    end
  end
end
