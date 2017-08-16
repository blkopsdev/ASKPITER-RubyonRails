class AddHostToVideo < ActiveRecord::Migration
  def change
    change_table :videos do |t|
      t.string :host, limit: 10
      t.string :code, limit: 20
    end
  end
end
