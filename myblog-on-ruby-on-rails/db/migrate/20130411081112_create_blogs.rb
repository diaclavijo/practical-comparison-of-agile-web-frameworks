class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :title
      t.string :description
      t.references :user

      t.timestamps
    end
    add_index :blogs, :user_id
  end
end
