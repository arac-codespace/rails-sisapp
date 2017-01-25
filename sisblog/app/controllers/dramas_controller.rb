class DramasController < ApplicationController
  #Breadcrumb display order.
  add_breadcrumb "Inicio", :root_path 
  add_breadcrumb "Reseñas", :resenas_path
  add_breadcrumb "Indice Drama", :dramas_path
  


  # GET /dramas  
  def index
    @q = Drama.ransack(params[:q])
    @dramas = @q.result(distinct: true)
    @category = params[:cat] #Variable catches query string for categorized views.
  end
  
  # GET /dramas/new
  def new
    @drama = Drama.new
    add_breadcrumb "Add a new entry."
  end
  
  # GET /dramas/:id
  def show
    @drama_show = Drama.find(params[:id])
     add_breadcrumb "Drama"
  end
  
  # GET /dramas/:id/edit
  def edit
    @drama = Drama.find(params[:id])
    add_breadcrumb "Edit entry."    
  end
  
  # PUT /dramas/:id
  def update
    @drama = Drama.find(params[:id])
    if @drama.update_attributes(drama_params)
      flash[:success] = "Profile updated!"
      # Redirect to the drama's profile
      redirect_to drama_path(id: params[:id])
    else
      render action: :edit #Don't send, go back to edit action.
    end
  end
  
  # DELETE /dramas/:id
  def destroy
    @drama = Drama.find(params[:id])
    @drama.destroy
    flash.notice= "Profile deleted."
    # Redirect to dramas index
    redirect_to dramas_path
  end
  
  #POST /dramas
  def create
      # Mass assignment of form fields into Drama object
      @drama = Drama.new(drama_params)
      # Save the Drama object to the database
      if @drama.save
        flash[:success] = " Profile created."
        redirect_to dramas_path 
      else
        flash[:danger] = "Error: Profile not saved."
        redirect_to dramas_path
      end
  end
  
  private
  # To collect data from form, we need to use strong parameters
  # and whitelist the form fields
    def drama_params
        params.require(:drama).permit(:title, :drama_description, :avatar, :category, :actors, :release_date, :comments, :rating)
    end

  
end