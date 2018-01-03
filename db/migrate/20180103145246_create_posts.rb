class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.bigint :identifier
      t.string :caption
      t.string :attachment_url
      t.string :social_media
      t.timestamps null: false
    end
  end
end
