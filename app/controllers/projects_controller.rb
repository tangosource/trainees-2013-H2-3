class ProjectsController < ApplicationController
  
  before_filter :authenticate_user!, except:[:index,:show]
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
    @projects = Project.all
    respond_to do |format|
      format.html
      format.json { render json: @projects}
    end
  end

  def show
    @project = Project.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @project}
    end
  end

  def new
    @project = Project.new
  end

  def edit
    @project = Project.find(params[:id])
  end

  def create
    @project = Project.new(project_params)
    if params[:preview] 
      render "new"
    else @project.save
      UserMailer.project_notification(@project.name).deliver
      redirect_to @project, notice: "Project was successfully created."
    end
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
      redirect_to @project, notice: "Project was successfully updated."
    else
      render "edit"
    end
  end

  def approve
    @project = Project.find(params[:id])
    @project.approve!
    redirect_to projects_url
  end

  def destroy
    redirect_to projects_url if @project.destroy
  end

private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit( :name, :city, :close_date, :description, :amount, :video_url,:user_id, :category_id, :approved)
  end
end
