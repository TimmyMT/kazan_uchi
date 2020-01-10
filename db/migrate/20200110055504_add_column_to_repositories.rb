class AddColumnToRepositories < ActiveRecord::Migration[5.2]
  def change
    add_column :repositories, :api_contributors_url, :string
  end
end
