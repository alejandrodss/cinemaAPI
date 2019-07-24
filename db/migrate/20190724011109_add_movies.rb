class AddMovies < ActiveRecord::Migration[5.2]
  def up
    create_table :movies do |table|
      table.string :name
      table.string :description
      table.string :image_url
    end
  end

  def down
    drop_table :movies
  end
end
