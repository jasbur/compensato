class CreateSystemInfos < ActiveRecord::Migration
  def change
    create_table :system_infos do |t|

      t.timestamps
    end
  end
end
