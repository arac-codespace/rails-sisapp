class DramasController < ApplicationController
  add_breadcrumb "Inicio", :root_path 
  add_breadcrumb "Reseñas", :resenas_path
  add_breadcrumb "Indice Drama", :dramas_path
  


  # GET /drama_index  
  def index
    @dramas = Drama.all
    @category = params[:cat]
  end
  
  # GET /drama_index/new
  def new
    @drama = Drama.new
    add_breadcrumb "Create new entry"
  end
  
  def show
    @drama_show = Drama.find(params[:id])
     add_breadcrumb "Drama"
  end
  
  def edit
    @drama = Drama.find(params[:id])
    add_breadcrumb "Edit entry"    
  end
  
  def update
    @drama = Drama.find(params[:id])
    if @drama.update_attributes(drama_params)
      flash[:success] = "Profile updated!"
      # Redirect to the drama's profile
      redirect_to drama_path(id: params[:id])
    else
      render action: :edit
    end
  end
  
  def destroy
    @drama = Drama.find(params[:id])
    @drama.destroy
    flash.notice="Drama deleted"

    redirect_to dramas_path
  end
  
  def create
      # Mass assignment of form fields into Contact object
      @drama = Drama.new(drama_params)
      # Save the Contact object to the database
      if @drama.save
        flash[:success] = "Message Sent."
        redirect_to dramas_path 
      else
        flash[:danger] = "Error: profile not saved."
        redirect_to dramas_path
      end
  end
  
  private
  # To collect data from form, we need to use strong parameters
  # and whitelist the form fields
    def drama_params
        params.require(:drama).permit(:title, :drama_description, :avatar, :category, :actors, :release_date, :comments)
    end

  
end