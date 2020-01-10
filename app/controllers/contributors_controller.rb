class ContributorsController < ApplicationController
  def show
    @contributor = Contributor.find(params[:id])
    respond_to do |format|
      format.pdf do
        # render pdf: "#{@contributor.login}.pdf", template: "contributors/show.html.slim"
        @pdf = render_to_string pdf: "#{@contributor.login}.pdf",
                                template: "contributors/show.html.slim",
                                encoding: "UTF-8"

        send_data(@pdf, filename: "#{@contributor.login}.pdf", type: "application/pdf")
      end
    end
  end
end
