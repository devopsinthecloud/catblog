class CreatePictureComments < ActiveRecord::Migration[7.0]
  def change
    create_table :picture_comments do |t|
      t.string :name
      t.references :picture, null: false, foreign_key: true

      t.timestamps
    end
  end
end
