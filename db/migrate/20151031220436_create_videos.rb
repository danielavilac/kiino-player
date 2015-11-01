class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :url
      t.string :user
      t.string :team
      t.string :channel

      t.timestamps null: false
    end
  end
end
