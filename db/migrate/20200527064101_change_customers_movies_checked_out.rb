class ChangeCustomersMoviesCheckedOut < ActiveRecord::Migration[6.0]
  def change
    rename_column :customers, :movies_checked_out_count, :videos_checked_out_count
  end
end
