class RepositoriesController < ApplicationController
  def new
    @repository = Repository.new
  end

  def create
    @repository = Repository.create(repository_params)
    if @repository.persisted?
      ContributorsGenService.new(@repository).call
      redirect_to repository_path(@repository)
    else
      render :new
    end
  end

  def show
    @repository = Repository.find(params[:id])
  end

  private

  def repository_params
    params.require(:repository).permit(:url)
  end
end
