require 'rails_helper'

RSpec.describe Contributor, type: :model do
  it { should belong_to(:repository) }
  it { should validate_presence_of(:login) }
  it { should validate_presence_of(:api_url) }
  it { should validate_presence_of(:html_url) }
  it { should validate_presence_of(:contributions) }
end
