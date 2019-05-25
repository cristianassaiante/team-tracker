class CreateSolves < ActiveRecord::Migration[5.2]
  def change
    create_table :solves do |t|

      t.timestamps
    end
  end
end
