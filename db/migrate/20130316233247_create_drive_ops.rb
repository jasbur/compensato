class CreateDriveOps < ActiveRecord::Migration
  def change
    create_table :drive_ops do |t|

      t.timestamps
    end
  end
end
