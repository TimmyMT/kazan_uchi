require 'rails_helper'

RSpec.describe Repository, type: :model do
  it { should have_many(:contributors).dependent(:destroy) }
  it { should validate_presence_of(:url) }

  context 'callbacks' do
    let!(:last_repository) { create(:repository) }

    it "before_create :already_exists?" do
      expect(Repository.count).to eq 1
      Repository.create!(url: last_repository.url)
      expect(Repository.count).to eq 1
    end

    it "after_create :checked_url with valid url" do
      new_repo = Repository.new(url: "http://github.com/rails/rails")
      expect(new_repo.valid_api_url).to be_falsey

      new_repo = Repository.create!(url: "http://github.com/rails/rails")

      expect(new_repo.persisted?).to be_truthy
      expect(new_repo.valid_api_url).to be_truthy

      expect(new_repo.user).to eq 'rails'
      expect(new_repo.repo).to eq 'rails'
    end

    it "after_create :checked_url with invalid url" do
      new_repo = Repository.new(url: "http://github.com/rails")
      expect(new_repo.valid_api_url).to be_falsey
      new_repo.save

      expect(new_repo.persisted?).to be_falsey
      expect(new_repo.valid?).to be_falsey

      new_repo.valid?
      expect(new_repo.errors[:url]).to eq ["wrong path for repo"]
    end

    it "validate :corrected_url" do
      new_repo = Repository.new(url: "google.com")
      new_repo.save

      expect(new_repo.persisted?).to be_falsey
      expect(new_repo.valid?).to be_falsey

      new_repo.valid?
      expect(new_repo.errors[:url]).to eq ["Is not Github"]
    end
  end

end
