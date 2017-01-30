class CaresController < ApplicationController
  #Breadcrumb display order.
  add_breadcrumb "Inicio", :root_path 
  add_breadcrumb "Cuidado Personal", :cuidado_personal_path
  add_breadcrumb "Indice Cuidado Personal", :cares_path

  
  
  # GET /books  
  def index
    @q = Care.ransack(params[:q])
    @cares = @q.result(distinct: true).paginate(page: params[:page], per_page: 10)
    @category = params[:cat] #Variable catches query string for categorized views.
    # @category = params[:cat] #Variable catches query string for categorized views.
  end
  
  # GET /books/new
  def new
    @care = Care.new
    add_breadcrumb "Añade una nueva entrada!"
  end
  
  # GET /books/:id
  def show
    @care_show = Care.find(params[:id])
    @page_url = request.original_url
     add_breadcrumb "Cuidado Personal"
  end
  
  # GET /books/:id/edit
  def edit
    @care = Care.find(params[:id])
    add_breadcrumb "Editar articulo"    
  end
  
  # PUT /books/:id
  def update
    @care = Care.find(params[:id])
    if @care.update_attributes(care_params)
      flash[:success] = "Articulo Revisado!"
      # Redirect to the book's profile
      redirect_to care_path(id: params[:id])
    else
      render action: :edit #Don't send, go back to edit action.
    end
  end
  
  # DELETE /books/:id
  def destroy
    @care = Care.find(params[:id])
    @care.destroy
    flash.notice= "Articulo eliminado."
    # Redirect to books index
    redirect_to cares_path
  end
  
  #POST /books
  def create
      # Mass assignment of form fields into Book object
      @care = Care.new(care_params)
      # Save the Book object to the database
      if @care.save
        # When the model is saved, have public_activity track this activity and
        # associate it with the create action.
        @care.create_activity :create
        flash[:success] = " Articulo creado!"
        redirect_to cares_path 
      else
        flash[:danger] = "Error: Articulo no se pudo crear."
        redirect_to cares_path
      end
  end
  
  private
  # To collect data from form, we need to use strong parameters
  # and whitelist the form fields
    def care_params
        params.require(:care).permit(:title, :category, :care_description, :comments)
    end

  
end