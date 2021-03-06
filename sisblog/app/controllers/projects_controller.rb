class ProjectsController < ApplicationController
  #Breadcrumb display order.
  add_breadcrumb "Inicio", :root_path 
  add_breadcrumb "Nuestras Historias", :projects_path


  # GET /projects  
  def index
    @q = Project.ransack(params[:q])
    @projects = @q.result(distinct: true).paginate(page: params[:page], per_page: 10)
  end
  
  # GET /projects/new
  def new
    @project = Project.new
    add_breadcrumb "Añade una nueva entrada!"
  end
  
  # GET /projects/:id
  def show
      
    @project_show = Project.find(params[:id])
    @chapter_list = Chapter.where(project_id: @project_show.id)    
    @page_url = request.original_url

    add_breadcrumb "#{@project_show.title}"
  end
  
  # GET /projects/:id/edit
  def edit
    @project = Project.find(params[:id])
    @project_id = params[:id]
    
    add_breadcrumb "#{@project.title}", project_path(id: @project_id)
    add_breadcrumb "Editar historia"    
  end
  
  # PUT /projects/:id
  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(project_params)
      flash[:success] = "Historia revisada!"
      # Redirect to the project's profile
      redirect_to project_path(id: params[:id])
    else
      render action: :edit #Don't send, go back to edit action.
    end
  end
  
  # DELETE /projects/:id
  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    flash.notice= "Historia eliminada."
    # Redirect to projects index
    redirect_to projects_path
  end
  
  #POST /projects
  def create
      # Mass assignment of form fields into Project object
      @project = Project.new(project_params)
      # Save the Project object to the database
      if @project.save
        # When the model is saved, have public_activity track this activity and
        # associate it with the create action.
        @project.create_activity :create
        flash[:success] = " Historia creada!"
        redirect_to projects_path 
      else
        flash[:danger] = "Error: Historia no se pudo añadir."
        redirect_to projects_path
      end
  end
  
  private
  # To collect data from form, we need to use strong parameters
  # and whitelist the form fields
    def project_params
        params.require(:project).permit(:title, :project_description, :avatar, :category, :comments)
    end

  
end