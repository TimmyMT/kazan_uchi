class RepositoriesController < ApplicationController
  def new
    @repository = Repository.new
  end

  def create
    @repository = Repository.create(repository_params)

    if @repository.valid_api_url?
      ContributorsGenService.new(@repository).call
    end
  end

  def show
    @repository = Repository.find(params[:id])
    @contributors = @repository.contributors
  end

  private

  def repository_params
    params.require(:repository).permit(:url)
  end
end
