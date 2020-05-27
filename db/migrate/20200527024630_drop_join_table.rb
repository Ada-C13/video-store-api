class DropJoinTable < ActiveRecord::Migration[6.0]
  def up
    drop_table :customers_videos_joins
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
