class CreateDiagnostics < ActiveRecord::Migration
  def change
    create_table :diagnostics do |t|

      t.timestamps
    end
  end
end
