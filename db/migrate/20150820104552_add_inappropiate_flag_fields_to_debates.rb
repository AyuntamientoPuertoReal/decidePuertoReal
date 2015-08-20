class AddInappropiateFlagFieldsToDebates < ActiveRecord::Migration
  def change
    add_column :debates, :flagged_as_inappropiate_at, :datetime
    add_column :debates, :inappropiate_flags_count, :integer, default: 0
  end
end
