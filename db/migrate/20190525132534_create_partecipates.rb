class CreatePartecipates < ActiveRecord::Migration[5.2]
  def change
    create_table :partecipates do |t|

      t.timestamps
    end
  end
end
