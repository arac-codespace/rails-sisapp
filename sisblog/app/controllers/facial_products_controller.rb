class FacialProductsController < ApplicationController
  #Breadcrumb display order.
  add_breadcrumb "Inicio", :root_path 
  add_breadcrumb "Reseñas", :resenas_path
  add_breadcrumb "Indice Facial Product", :facial_products_path
  


  # GET /dramas  
  def index
    @q = FacialProduct.ransack(params[:q])
    @facialproducts = @q.result(distinct: true)
    # @category = params[:cat] #Variable catches query string for categorized views.
  end
  
  # GET /dramas/new
  def new
    @facialproduct = FacialProduct.new
    add_breadcrumb "Add a new entry."
  end
  
  # GET /dramas/:id
  def show
    @facialproduct_show = FacialProduct.find(params[:id])
     add_breadcrumb "Facial Product"
  end
  
  # GET /dramas/:id/edit
  def edit
    @facialproduct = FacialProduct.find(params[:id])
    add_breadcrumb "Edit entry."    
  end
  
  # PUT /dramas/:id
  def update
    @facialproduct = FacialProduct.find(params[:id])
    if @facialproduct.update_attributes(facialproduct_params)
      flash[:success] = "Profile updated!"
      # Redirect to the drama's profile
      redirect_to facial_product_path(id: params[:id])
    else
      render action: :edit #Don't send, go back to edit action.
    end
  end
  
  # DELETE /dramas/:id
  def destroy
    @facialproduct = FacialProduct.find(params[:id])
    @facialproduct.destroy
    flash.notice= "Profile deleted."
    # Redirect to dramas index
    redirect_to facial_products_path
  end
  
  #POST /dramas
  def create
      # Mass assignment of form fields into Drama object
      @facialproduct = FacialProduct.new(facialproduct_params)
      # Save the Drama object to the database
      if @facialproduct.save
        # When the model is saved, have public_activity track this activity and
        # associate it with the create action.
        @facialproduct.create_activity :create
        flash[:success] = " Profile created."
        redirect_to facial_products_path 
      else
        flash[:danger] = "Error: Profile not saved."
        redirect_to facial_products_path
      end
  end
  
  private
  # To collect data from form, we need to use strong parameters
  # and whitelist the form fields
    def facialproduct_params
        params.require(:facial_product).permit(:title, :facialproduct_description, :avatar, :actors, :release_date, :comments, :rating)
    end

  
end