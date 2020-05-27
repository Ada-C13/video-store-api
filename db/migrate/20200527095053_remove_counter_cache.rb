class RemoveCounterCache < ActiveRecord::Migration[6.0]
  def change
    remove_column :customers, :videos_checked_out_count
  end
end
