class CreateAlmanac < ActiveRecord::Migration
  def self.up
    create_table :almanac_entries do |t|
      t.string :title
      t.text   :data

      t.timestamps
    end

    create_table :almanac_tags do |t|
      t.references :almanac_entry
      t.references :tag, :polymorphic => true

      t.timestamps
    end

    create_table :almanac_labels do |t|
      t.string :name

      t.timestamps
    end

    add_index :almanac_tags, [:tag_id, :tag_type]
    add_index :almanac_tags, :almanac_entry_id
    add_index :almanac_labels, :name, :unique => true
  end

  def self.down
    drop_table :almanac_entries
    drop_table :almanac_tags
    drop_table :almanac_labels
  end
end