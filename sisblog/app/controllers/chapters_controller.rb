class ChaptersController < ApplicationController
  #Breadcrumb display order.
  add_breadcrumb "Inicio", :root_path 
  add_breadcrumb "Reseñas", :resenas_path
#   add_breadcrumb "Indice Chapters", :project_path
  


  # GET /chapters  
  def index
    @q = Chapter.ransack(params[:q])
    @chapters = @q.result(distinct: true).paginate(page: params[:page], per_page: 10)
    @category = params[:cat] #Variable catches query string for categorized views.
  end
  
  # GET /chapters/new
  def new
    @chapter = Chapter.new
    # add_breadcrumb "Añade una nueva entrada!"
  end
  
  # GET /chapters/:id
  def show
    
    @project_id = params[:project_id]
    @chapter_show = Chapter.find(params[:id])
    @chapters = Chapter.all

    @prev = Chapter.where("id < ? AND projects_id = ?", params[:id], @project_id).order(:id).first 
    @next = Chapter.where("id > ? AND projects_id = ?", params[:id], @project_id).order(:id).first 


  end
  
  # GET /chapters/:id/edit
  def edit
    @chapter = Chapter.find(params[:id])
    add_breadcrumb "Editar artículo"    
  end
  
  # PUT /chapters/:id
  def update
    @chapter = Chapter.find(params[:id])
    if @chapter.update_attributes(chapter_params)
      flash[:success] = "Artículo Revisado!"
      # Redirect to the chapter's profile
      redirect_to chapter_path(id: params[:id])
    else
      render action: :edit #Don't send, go back to edit action.
    end
  end
  
  # DELETE /chapters/:id
  def destroy
    @chapter = Chapter.find(params[:id])
    @chapter.destroy
    flash.notice= "Artículo eliminado."
    # Redirect to chapters index
    redirect_to chapters_path
  end
  
  #POST /chapters
  def create
      # Mass assignment of form fields into Chapter object
      @chapter = Chapter.new(chapter_params)
      # Save the Chapter object to the database
      if @chapter.save
        # When the model is saved, have public_activity track this activity and
        # associate it with the create action.
        @chapter.create_activity :create
        flash[:success] = " Artículo creado!"
        redirect_to projects_path 
      else
        flash[:danger] = "Error: Artículo no se pudo crear."
        render action: :new
      end
  end
  
  private
  # To collect data from form, we need to use strong parameters
  # and whitelist the form fields
    def chapter_params
        params.require(:chapter).permit(:chapter_number, :chapter_text, :projects_id)
    end

  
end