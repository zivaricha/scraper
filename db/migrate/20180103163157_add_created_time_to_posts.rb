class AddCreatedTimeToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :original_created_time, :datetime
  end
end
