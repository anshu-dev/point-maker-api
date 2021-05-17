class RemoveLongitudeAndLatitudeFromPoints < ActiveRecord::Migration[6.1]
  def up
    remove_column :points, :latitude
    remove_column :points, :longitude
  end

  def down
    add_column :points, :latitude, :string
    add_column :points, :longitude, :string
  end
end
