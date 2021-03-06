class CraftsController < ApplicationController
  #Breadcrumb display order.
  add_breadcrumb "Inicio", :root_path 
  add_breadcrumb "Indice Manualidades", :crafts_path
  


  # GET /crafts  
  def index
    @q = Craft.ransack(params[:q])
    @crafts = @q.result(distinct: true).paginate(page: params[:page], per_page: 10)
    # @category = params[:cat] #Variable catches query string for categorized views.
  end
  
  # GET /crafts/new
  def new
    @craft = Craft.new
    add_breadcrumb "Añade una nueva entrada!"
  end
  
  # GET /crafts/:id
  def show
    @craft_show = Craft.find(params[:id])
    @page_url = request.original_url

    add_breadcrumb "#{@craft_show.title}"
  end
  
  # GET /crafts/:id/edit
  def edit
    @craft = Craft.find(params[:id])
    @craft_id = params[:id]
    
    add_breadcrumb "#{@craft.title}", craft_path(id: @craft_id)    
    add_breadcrumb "Editar artículo"    
  end
  
  # PUT /crafts/:id
  def update
    @craft = Craft.find(params[:id])
    if @craft.update_attributes(craft_params)
      flash[:success] = "Artículo Revisado!"
      # Redirect to the craft's profile
      redirect_to craft_path(id: params[:id])
    else
      render action: :edit #Don't send, go back to edit action.
    end
  end
  
  # DELETE /crafts/:id
  def destroy
    @craft = Craft.find(params[:id])
    @craft.destroy
    flash.notice= "Artículo eliminado."
    # Redirect to crafts index
    redirect_to crafts_path
  end
  
  #POST /crafts
  def create
      # Mass assignment of form fields into Craft object
      @craft = Craft.new(craft_params)
      # Save the Craft object to the database
      if @craft.save
        # When the model is saved, have public_activity track this activity and
        # associate it with the create action.
        @craft.create_activity :create
        flash[:success] = " Artículo creado!"
        redirect_to crafts_path 
      else
        flash[:danger] = "Error: Artículo no se pudo crear."
        redirect_to crafts_path
      end
  end
  
  private
  # To collect data from form, we need to use strong parameters
  # and whitelist the form fields
    def craft_params
        params.require(:craft).permit(:title, :craft_description, :comments, :avatar)
    end

  
end