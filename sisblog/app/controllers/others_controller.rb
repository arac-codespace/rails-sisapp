class OthersController < ApplicationController
  #Breadcrumb display order.
  add_breadcrumb "Inicio", :root_path 
  add_breadcrumb "Reseñas", :resenas_path
  add_breadcrumb "Indice Otros", :others_path
  


  # GET /others  
  def index
    @q = Other.ransack(params[:q])
    @others = @q.result(distinct: true).paginate(page: params[:page], per_page: 10)
    # @category = params[:cat] #Variable catches query string for categorized views.
  end
  
  # GET /others/new
  def new
    @other = Other.new
    add_breadcrumb "Añade una nueva entrada!"
  end
  
  # GET /others/:id
  def show
    @other_show = Other.find(params[:id])
    @page_url = request.original_url
     add_breadcrumb "Otro"
  end
  
  # GET /others/:id/edit
  def edit
    @other = Other.find(params[:id])
    add_breadcrumb "Editar artículo"    
  end
  
  # PUT /others/:id
  def update
    @other = Other.find(params[:id])
    if @other.update_attributes(other_params)
      flash[:success] = "Artículo Revisado!"
      # Redirect to the other's profile
      redirect_to other_path(id: params[:id])
    else
      render action: :edit #Don't send, go back to edit action.
    end
  end
  
  # DELETE /others/:id
  def destroy
    @other = Other.find(params[:id])
    @other.destroy
    flash.notice= "Artículo eliminado."
    # Redirect to others index
    redirect_to others_path
  end
  
  #POST /others
  def create
      # Mass assignment of form fields into Other object
      @other = Other.new(other_params)
      # Save the Other object to the database
      if @other.save
        # When the model is saved, have public_activity track this activity and
        # associate it with the create action.
        @other.create_activity :create
        flash[:success] = " Artículo creado!"
        redirect_to others_path 
      else
        flash[:danger] = "Error: Artículo no se pudo crear."
        redirect_to others_path
      end
  end
  
  private
  # To collect data from form, we need to use strong parameters
  # and whitelist the form fields
    def other_params
        params.require(:other).permit(:title, :other_description, :avatar, :actors, :release_date, :comments, :rating)
    end

  
end