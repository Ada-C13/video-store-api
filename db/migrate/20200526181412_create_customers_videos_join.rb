class CreateCustomersVideosJoin < ActiveRecord::Migration[6.0]
  def change
    create_table :customers_videos_joins do |t|
      t.belongs_to :customer, index: true
      t.belongs_to :video, index: true
    end
  end
end
