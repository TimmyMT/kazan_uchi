class CreateContributors < ActiveRecord::Migration[5.2]
  def change
    create_table :contributors do |t|
      t.references :repository, foreign_key: true
      t.string :login
      t.string :api_url
      t.string :html_url
      t.integer :contributions

      t.timestamps
    end
  end
end
