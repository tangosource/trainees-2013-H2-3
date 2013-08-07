class ProjectsController < ApplicationController
  
  before_action :set_project, only: [:show]

  def index
    @projects = Project.all

    respond_to do |format|
      format.html
      format.json { render json: @projects}
    end
  end

  def show
    flash[:notice] = ""
    @project = Project.find(params[:id])
    @users = User.joins(:backs).where(backs: {project_id: params[:id]})
    @owner = User.find(@project.user_id)
    project_time_to_close
    respond_to do |format|
      format.html
    end
  end
  def project_time_to_close
    @project = Project.find(params[:id])
    @time_now = Time.now
    if @time_now >= @project.close_date
      flash[:notice] = "The Project was Closer"
      @close_date = 1
    else
      @close_date = 0
    end
  end
private

  def set_project
    @project = Project.find(params[:id])
  end

end
