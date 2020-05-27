class RenamedCounterColumn < ActiveRecord::Migration[6.0]
  def change
    rename_column :customers, :rentals_count, :videos_checked_out_count
  end
end
