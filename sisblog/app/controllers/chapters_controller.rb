class ChaptersController < ApplicationController
  #Breadcrumb display order.
  add_breadcrumb "Inicio", :root_path 
  add_breadcrumb "Nuestras Historias", :projects_path
#   add_breadcrumb "Indice Chapters", :project_path
  
  
  # GET /chapters/new
  def new
    @chapter = Chapter.new
    @project_id = params[:project_id]
    @project_title = Project.find(@project_id)
    
    add_breadcrumb "#{@project_title.title}", project_path(id: @project_id)
    
    add_breadcrumb "Añade un nuevo capítulo!"
  end
  
  # GET /chapters/:id
  def show
    
    @project_id = params[:project_id]
    @project_title = Project.find(@project_id)
    @chapter_show = Chapter.find(params[:id])
    @chapters = Chapter.all

    # Some explanation is necessary here for future reference...
    # So, project_id catches the project_id parameter from the URL.
    # The parameter is used to find the corresponding Project record in project_title.
    # project_title is later used to query the title for breadcrumbs and to find
    # the corresponding Project row for the prev/next button function.
    
    # The following lines are the prev/next record functions.
    # In this function chapter_show is used to provide the id for the first comparison
    
    @prev = Chapter.where("id < ? AND project_id = ?", @chapter_show, @project_title).order(:id).last
    @next = Chapter.where("id > ? AND project_id = ?", @chapter_show, @project_title).order(:id).first 
    
    # The following lines are the breadcrumb lines from the breadcrumb gem.
    # Here we pass the model instead of the ID so that the modified to_param
    # function which provides the custom URLs can be used.
    
    add_breadcrumb "#{@project_title.title}", project_path(id: @project_id)
    add_breadcrumb "#{@chapter_show.chapter_number}"


  end
  
  # GET /chapters/:id/edit
  def edit
  
    @project_id = params[:project_id]
    @project_title = Project.find(@project_id)
    @chapter_show = Chapter.find(params[:id])
    
    @chapter = Chapter.find(params[:id])
    
    add_breadcrumb "#{@project_title.title}", project_path(id: @project_id)
    add_breadcrumb "Editar Capítulo - #{@chapter_show.chapter_number}"
    
  end
  
  # PUT /chapters/:id
  def update
    @chapter = Chapter.find(params[:id])
    @project_id = params[:project_id]
    if @chapter.update_attributes(chapter_params)
      flash[:success] = "Capítulo Revisado!"
      # Redirect to the chapter's profile
      redirect_to project_path(id: @project_id)
    else
      render action: :edit #Don't send, go back to edit action.
    end
  end
  
  # DELETE /chapters/:id
  def destroy
    @chapter = Chapter.find(params[:id])
    @project_id = params[:project_id]
    @chapter.destroy
    flash.notice= "Capítulo eliminado."
    # Redirect to chapters index
    redirect_to project_path(id: @project_id)
  end
  
  #POST /chapters
  def create
      # Mass assignment of form fields into Chapter object
      @chapter = Chapter.new(chapter_params)
      # Grabs var from url for redirect command
      @project_id = params[:project_id]
      # Save the Chapter object to the database
      if @chapter.save
        # When the model is saved, have public_activity track this activity and
        # associate it with the create action.
        @chapter.create_activity :create
        flash[:success] = " Capítulo creado!"
        redirect_to project_path(id: @project_id)
      else
        flash[:danger] = "Error: Capítulo no se pudo crear."
        render action: :new
      end
  end
  
  private
  # To collect data from form, we need to use strong parameters
  # and whitelist the form fields
    def chapter_params
        params.require(:chapter).permit(:chapter_number, :chapter_text, :project_id)
    end

  
end