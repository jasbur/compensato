class CreateFileOps < ActiveRecord::Migration
  def change
    create_table :file_ops do |t|

      t.timestamps
    end
  end
end
