class AddColumnsToRepositories < ActiveRecord::Migration[5.2]
  def change
    add_column :repositories, :user, :string
    add_column :repositories, :repo, :string
  end
end
