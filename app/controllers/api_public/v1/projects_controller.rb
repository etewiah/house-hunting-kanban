class ApiPublic::V1::ProjectsController < ApiPublicApplicationController
  def update
    @project = Project.find(params[:id])
    @project.title = params[:title]
    @project.save!
    return render "show.json"
  end

  def show
    @project = Project.find(params[:id])
    return render "show.json"
  end
end
