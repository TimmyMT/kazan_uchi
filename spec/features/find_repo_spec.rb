require 'rails_helper'

feature 'Repositories' do
  context "guest can find repo", js: true do
    before do
      visit new_repository_path
    end

    it "render new view" do
      expect(page).to have_content "Find repo:"
      expect(page).to have_css ".search-repo-form"
    end

    it "search repo with valid url" do
      within ".search-repo-form" do
        fill_in 'Url', with: "https://github.com/rails/rails"
        click_on 'Search'
      end

      within ".generated-repo" do
        expect(page).to have_content Repository.last.contributors.first.login
        expect(page).to have_link 'download pdf'
      end
    end

    it "search repo with invalid url" do
      within ".search-repo-form" do
        fill_in 'Url', with: "https://github.com/rails"
        click_on 'Search'
      end

      within ".generated-repo" do
        expect(page).to have_content "This repo not exist"
        expect(page).to_not have_link 'download pdf'
      end
    end

    it "search repo with not exist repo url" do
      within ".search-repo-form" do
        fill_in 'Url', with: "https://github.com/TimmyMT/fake_repo_TimmyMT"
        click_on 'Search'
      end

      within ".generated-repo" do
        expect(page).to have_content "This repo not exist"
        expect(page).to_not have_link 'download pdf'
      end
    end

    it "search repo with not repo url" do
      within ".search-repo-form" do
        fill_in 'Url', with: "https://google.com"
        click_on 'Search'
      end

      within ".generated-repo" do
        expect(page).to have_content "This repo not exist"
        expect(page).to_not have_link 'download pdf'
      end
    end
  end
end
