class CreatePlayswiths < ActiveRecord::Migration[5.2]
  def change
    create_table :playswiths do |t|

      t.timestamps
    end
  end
end
