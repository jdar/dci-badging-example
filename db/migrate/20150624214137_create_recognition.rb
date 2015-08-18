class CreateRecognition < ActiveRecord::Migration
  def change
    create_table :recognitions do |t|
      t.integer :user_id, :index=>true,:foreign_key=>true
      t.integer :badge_id
    end
  end
end
