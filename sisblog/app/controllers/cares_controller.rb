class CaresController < ApplicationController
  #Breadcrumb display order.
  add_breadcrumb "Inicio", :root_path 
  add_breadcrumb "Cuidado Personal", :cuidado_personal_path
  add_breadcrumb "Indice Care", :cares_path

  
  


  # GET /dramas  
  def index
    @q = Care.ransack(params[:q])
    @cares = @q.result(distinct: true)
    @category = params[:cat] #Variable catches query string for categorized views.
    # @category = params[:cat] #Variable catches query string for categorized views.
  end
  
  # GET /dramas/new
  def new
    @care = Care.new
    add_breadcrumb "Add a new entry."
  end
  
  # GET /dramas/:id
  def show
    @care_show = Care.find(params[:id])
     add_breadcrumb "Care"
  end
  
  # GET /dramas/:id/edit
  def edit
    @care = Care.find(params[:id])
    add_breadcrumb "Edit entry."    
  end
  
  # PUT /dramas/:id
  def update
    @care = Care.find(params[:id])
    if @care.update_attributes(care_params)
      flash[:success] = "Profile updated!"
      # Redirect to the drama's profile
      redirect_to care_path(id: params[:id])
    else
      render action: :edit #Don't send, go back to edit action.
    end
  end
  
  # DELETE /dramas/:id
  def destroy
    @care = Care.find(params[:id])
    @care.destroy
    flash.notice= "Profile deleted."
    # Redirect to dramas index
    redirect_to cares_path
  end
  
  #POST /dramas
  def create
      # Mass assignment of form fields into Drama object
      @care = Care.new(care_params)
      # Save the Drama object to the database
      if @care.save
        # When the model is saved, have public_activity track this activity and
        # associate it with the create action.
        @care.create_activity :create
        flash[:success] = " Profile created."
        redirect_to cares_path 
      else
        flash[:danger] = "Error: Profile not saved."
        redirect_to cares_path
      end
  end
  
  private
  # To collect data from form, we need to use strong parameters
  # and whitelist the form fields
    def care_params
        params.require(:care).permit(:title, :categories, :care_description, :comments)
    end

  
end