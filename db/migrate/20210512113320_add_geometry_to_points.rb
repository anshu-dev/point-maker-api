class AddGeometryToPoints < ActiveRecord::Migration[6.1]
  def change
    add_column :points, :geometry, :jsonb
  end
end
