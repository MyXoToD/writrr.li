class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password
      t.string :name
      t.string :image
      t.string :link
      t.string :location
      t.text :bio

      t.timestamps
    end
  end
end
