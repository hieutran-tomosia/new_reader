class CreateBests < ActiveRecord::Migration[6.1]
  def change
    create_table :bests do |t|

      t.timestamps
    end
  end
end
