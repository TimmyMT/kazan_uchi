require 'rails_helper'

RSpec.describe ContributorsGenService do
  let!(:repository) { create(:repository) }
  let!(:invalid_repo) { create(:repository, :not_exist_repo) }


  describe "with valid repo" do
    subject { ContributorsGenService.new(repository) }

    it "service #call" do
      contributors_count_before = repository.contributors.count
      expect(contributors_count_before).to eq 0

      subject.call
      expect(repository.contributors.count).to be > contributors_count_before
    end
  end

  describe "with invalid repo" do
    subject { ContributorsGenService.new(invalid_repo) }

    it "service #call" do
      contributors_count_before = repository.contributors.count
      expect(contributors_count_before).to eq 0

      subject.call
      expect(repository.contributors.count).to eq contributors_count_before
    end
  end
end
