class AddColumnValidapiurlToRepositories < ActiveRecord::Migration[5.2]
  def change
    add_column :repositories, :valid_api_url, :boolean, default: false
  end
end
