class ChangeTypeOnCustomersTableVcocColumn < ActiveRecord::Migration[6.0]
  def change
    change_column :customers, :videos_checked_out_count, 'integer USING CAST(videos_checked_out_count AS integer)'
  end
end
