class Contributor < ApplicationRecord
  belongs_to :repository

  validates :login, :api_url, :html_url, :contributions, presence: true
end
