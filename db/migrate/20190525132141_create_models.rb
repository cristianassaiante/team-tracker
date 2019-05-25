class CreateModels < ActiveRecord::Migration[5.2]
  def change
    create_table :models do |t|
      t.string :Solves

      t.timestamps
    end
  end
end
