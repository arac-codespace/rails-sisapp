class MakeupsController < ApplicationController
  #Breadcrumb display order.
  add_breadcrumb "Inicio", :root_path 
  add_breadcrumb "Reseñas", :resenas_path
  add_breadcrumb "Indice Maquillajes", :makeups_path
  


  # GET /makeups  
  def index
    @q = Makeup.ransack(params[:q])
    @makeups = @q.result(distinct: true).paginate(page: params[:page], per_page: 10)
    # @category = params[:cat] #Variable catches query string for categorized views.
  end
  
  # GET /makeups/new
  def new
    @makeup = Makeup.new
    add_breadcrumb "Añade una nueva entrada!"
  end
  
  # GET /makeups/:id
  def show
    @makeup_show = Makeup.find(params[:id])
    @page_url = request.original_url
     add_breadcrumb "Maquillaje"
  end
  
  # GET /makeups/:id/edit
  def edit
    @makeup = Makeup.find(params[:id])
    add_breadcrumb "Editar artículo"    
  end
  
  # PUT /makeups/:id
  def update
    @makeup = Makeup.find(params[:id])
    if @makeup.update_attributes(makeup_params)
      flash[:success] = "Artículo Revisado!"
      # Redirect to the makeup's profile
      redirect_to makeup_path(id: params[:id])
    else
      render action: :edit #Don't send, go back to edit action.
    end
  end
  
  # DELETE /makeups/:id
  def destroy
    @makeup = Makeup.find(params[:id])
    @makeup.destroy
    flash.notice= "Artículo eliminado."
    # Redirect to makeups index
    redirect_to makeups_path
  end
  
  #POST /makeups
  def create
      # Mass assignment of form fields into Makeup object
      @makeup = Makeup.new(makeup_params)
      # Save the Makeup object to the database
      if @makeup.save
        # When the model is saved, have public_activity track this activity and
        # associate it with the create action.
        @makeup.create_activity :create
        flash[:success] = " Artículo creado!"
        redirect_to makeups_path 
      else
        flash[:danger] = "Error: Artículo no se pudo crear."
        redirect_to makeups_path
      end
  end
  
  private
  # To collect data from form, we need to use strong parameters
  # and whitelist the form fields
    def makeup_params
        params.require(:makeup).permit(:title, :makeup_description, :avatar, :company, :release_date, :comments, :rating)
    end

  
end