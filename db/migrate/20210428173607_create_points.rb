class CreatePoints < ActiveRecord::Migration[6.1]
  def change
    create_table :points do |t|
      t.string :name
      t.string :latitude
      t.string :longitude
      t.timestamps
    end
  end
end