class CreateQualifications < ActiveRecord::Migration
  def change
    create_table :qualifications do |t|
      t.string :key
      t.string :name
      t.text :country
      t.text :subjects_data
      t.string :link
      t.text :default_products

      t.timestamps
    end
    add_index :qualifications, :key
  end
end
