class ChangeResources < ActiveRecord::Migration
  # rails g migration ChangeResources
  # add_column :table_name, :column_name, :data_type, options
  # remove_column :table_name, :column_name
  # rename_column :table_name, :old_column, :new_column

  def up
    add_column :resources, :description_from_source, :text
    add_column :resources, :raw_html, :text
    rename_column :resources, :title_manual, :title_from_user
    rename_column :resources, :title_scraped, :title_from_source
    rename_column :resources, :description, :description_from_user
    rename_column :resources, :keywords_manual, :keywords_from_user
    rename_column :resources, :keywords_scraped, :keywords_from_source
  end

  def down
    remove_column :resources, :description_from_source
    remove_column :resources, :raw_html
    rename_column :resources, :title_from_user, :title_manual
    rename_column :resources, :title_from_source, :title_scraped
    rename_column :resources, :description_from_user, :description
    rename_column :resources, :keywords_from_user, :keywords_manual
    rename_column :resources, :keywords_from_source, :keywords_scraped
  end
end
