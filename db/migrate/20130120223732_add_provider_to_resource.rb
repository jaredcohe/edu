class AddProviderToResource < ActiveRecord::Migration
  # rails g migration add_provider_to_resource provider:text
  # add_column :table_name, :column_name, :data_type, options
  # remove_column :table_name, :column_name

  def up
    add_column :resources, :provider, :text
  end
  
  def down
    remove_column :resources, :provider
  end
end
