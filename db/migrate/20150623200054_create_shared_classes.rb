class CreateSharedClasses < ActiveRecord::Migration
  def change
    create_table :followings do |t|
      t.integer :user_id
      t.integer :peer_id
    end
  end
end
