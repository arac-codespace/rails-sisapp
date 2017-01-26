class OthersController < ApplicationController
  #Breadcrumb display order.
  add_breadcrumb "Inicio", :root_path 
  add_breadcrumb "Reseñas", :resenas_path
  add_breadcrumb "Indice Other", :others_path
  


  # GET /dramas  
  def index
    @q = Other.ransack(params[:q])
    @others = @q.result(distinct: true)
    # @category = params[:cat] #Variable catches query string for categorized views.
  end
  
  # GET /dramas/new
  def new
    @other = Other.new
    add_breadcrumb "Add a new entry."
  end
  
  # GET /dramas/:id
  def show
    @other_show = Other.find(params[:id])
     add_breadcrumb "Other"
  end
  
  # GET /dramas/:id/edit
  def edit
    @other = Other.find(params[:id])
    add_breadcrumb "Edit entry."    
  end
  
  # PUT /dramas/:id
  def update
    @other = Other.find(params[:id])
    if @other.update_attributes(other_params)
      flash[:success] = "Profile updated!"
      # Redirect to the drama's profile
      redirect_to other_path(id: params[:id])
    else
      render action: :edit #Don't send, go back to edit action.
    end
  end
  
  # DELETE /dramas/:id
  def destroy
    @other = Other.find(params[:id])
    @other.destroy
    flash.notice= "Profile deleted."
    # Redirect to dramas index
    redirect_to others_path
  end
  
  #POST /dramas
  def create
      # Mass assignment of form fields into Drama object
      @other = Other.new(other_params)
      # Save the Drama object to the database
      if @other.save
        # When the model is saved, have public_activity track this activity and
        # associate it with the create action.
        @other.create_activity :create
        flash[:success] = " Profile created."
        redirect_to others_path 
      else
        flash[:danger] = "Error: Profile not saved."
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