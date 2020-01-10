class ContributorsController < ApplicationController
  def show
    @contributor = Contributor.find(params[:id])
    respond_to do |format|
      format.pdf do
        render pdf: "#{@contributor.login}.pdf", template: "contributors/show.html.slim"
      end
    end
  end
end
