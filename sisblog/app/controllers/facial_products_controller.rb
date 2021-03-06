class FacialProductsController < ApplicationController
  #Breadcrumb display order.
  add_breadcrumb "Inicio", :root_path 
  add_breadcrumb "Reseñas", :resenas_path
  add_breadcrumb "Indice Productos Faciales", :facial_products_path
  


  # GET /facial_products  
  def index
    @q = FacialProduct.ransack(params[:q])
    @facialproducts = @q.result(distinct: true).paginate(page: params[:page], per_page: 10)
    # @category = params[:cat] #Variable catches query string for categorized views.
  end
  
  # GET /facial_products/new
  def new
    @facialproduct = FacialProduct.new
    add_breadcrumb "Añade una nueva entrada!"
  end
  
  # GET /facial_products/:id
  def show
    @facialproduct_show = FacialProduct.find(params[:id])
    @page_url = request.original_url

    add_breadcrumb "#{@facialproduct_show.title}"
  end
  
  # GET /facial_products/:id/edit
  def edit
    @facialproduct = FacialProduct.find(params[:id])
    @facialproduct_id = params[:id]
    
    add_breadcrumb "#{@facialproduct.title}", facial_product_path(id: @facialproduct_id)
    add_breadcrumb "Editar artículo"   
  end
  
  # PUT /facial_products/:id
  def update
    @facialproduct = FacialProduct.find(params[:id])
    if @facialproduct.update_attributes(facialproduct_params)
      flash[:success] = "Artículo Revisado!"
      # Redirect to the facial product's profile
      redirect_to facial_product_path(id: params[:id])
    else
      render action: :edit #Don't send, go back to edit action.
    end
  end
  
  # DELETE /facial_products/:id
  def destroy
    @facialproduct = FacialProduct.find(params[:id])
    @facialproduct.destroy
    flash.notice= "Artículo eliminado."
    # Redirect to facial_products index
    redirect_to facial_products_path
  end
  
  #POST /facial_products
  def create
      # Mass assignment of form fields into FacialProduct object
      @facialproduct = FacialProduct.new(facialproduct_params)
      # Save the FacialProduct object to the database
      if @facialproduct.save
        # When the model is saved, have public_activity track this activity and
        # associate it with the create action.
        @facialproduct.create_activity :create
        flash[:success] = " Artículo creado!"
        redirect_to facial_products_path 
      else
        flash[:danger] = "Error: Artículo no se pudo crear."
        redirect_to facial_products_path
      end
  end
  
  private
  # To collect data from form, we need to use strong parameters
  # and whitelist the form fields
    def facialproduct_params
        params.require(:facial_product).permit(:title, :facialproduct_description, :avatar, :company, :release_date, :comments, :rating)
    end

  
end