class ChangeMoviesCheckedOutCountName < ActiveRecord::Migration[6.0]
  def change
    remove_column :customers, :movies_checked_out_count
    add_column :customers, :videos_checked_out_count, :integer, default: 0
  end
end
