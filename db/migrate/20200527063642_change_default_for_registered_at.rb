class ChangeDefaultForRegisteredAt < ActiveRecord::Migration[6.0]
  def change
    change_column(:customers, :registered_at, :datetime, default: -> { 'CURRENT_TIMESTAMP' } )
  end
end
