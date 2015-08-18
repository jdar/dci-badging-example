class CreateBadges < ActiveRecord::Migration
  def change
    create_table :badges do |t|
      t.string :name
      t.string :filename
      t.string :description

      #eventually integrated with openbadge?
      t.string :url
      t.integer :points, default: 0

      t.belongs_to :school
    end
  end
end
