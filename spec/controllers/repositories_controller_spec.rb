require 'rails_helper'

RSpec.describe RepositoriesController, type: :controller do

  describe "GET #new" do
    it "tries to get new view" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    it "tries to create repo with valid attr" do
      expect do
        post :create, params: {repository: attributes_for(:repository), format: :js}
      end.to change(Repository, :count).by(1)

      expect(Repository.last.valid_api_url).to be_truthy
      expect(Repository.last.contributors.count).to be > 0
    end

    it "tries to create repo with invalid attr" do
      expect do
        post :create, params: {repository: attributes_for(:repository, :invalid_repository), format: :js}
      end.to_not change(Repository, :count)

      expect(Repository.all.count).to eq 0
      expect(Contributor.all.count).to eq 0
    end

    it "tries to create not exist repo" do
      expect do
        post :create, params: {repository: attributes_for(:repository, :not_exist_repo), format: :js}
      end.to change(Repository, :count).by(1)

      expect(Repository.last.valid_api_url).to be_falsey
      expect(Repository.last.contributors.count).to eq 0
    end
  end
end
