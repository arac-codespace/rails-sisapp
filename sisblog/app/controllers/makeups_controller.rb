class MakeupsController < ApplicationController
  #Breadcrumb display order.
  add_breadcrumb "Inicio", :root_path 
  add_breadcrumb "Reseñas", :resenas_path
  add_breadcrumb "Indice Makeup", :makeups_path
  


  # GET /dramas  
  def index
    @q = Makeup.ransack(params[:q])
    @makeups = @q.result(distinct: true)
    # @category = params[:cat] #Variable catches query string for categorized views.
  end
  
  # GET /dramas/new
  def new
    @makeup = Makeup.new
    add_breadcrumb "Add a new entry."
  end
  
  # GET /dramas/:id
  def show
    @makeup_show = Makeup.find(params[:id])
     add_breadcrumb "Makeup"
  end
  
  # GET /dramas/:id/edit
  def edit
    @makeup = Makeup.find(params[:id])
    add_breadcrumb "Edit entry."    
  end
  
  # PUT /dramas/:id
  def update
    @makeup = Makeup.find(params[:id])
    if @makeup.update_attributes(makeup_params)
      flash[:success] = "Profile updated!"
      # Redirect to the drama's profile
      redirect_to makeup_path(id: params[:id])
    else
      render action: :edit #Don't send, go back to edit action.
    end
  end
  
  # DELETE /dramas/:id
  def destroy
    @makeup = Makeup.find(params[:id])
    @makeup.destroy
    flash.notice= "Profile deleted."
    # Redirect to dramas index
    redirect_to makeups_path
  end
  
  #POST /dramas
  def create
      # Mass assignment of form fields into Drama object
      @makeup = Makeup.new(makeup_params)
      # Save the Drama object to the database
      if @makeup.save
        # When the model is saved, have public_activity track this activity and
        # associate it with the create action.
        @makeup.create_activity :create
        flash[:success] = " Profile created."
        redirect_to makeups_path 
      else
        flash[:danger] = "Error: Profile not saved."
        redirect_to makeups_path
      end
  end
  
  private
  # To collect data from form, we need to use strong parameters
  # and whitelist the form fields
    def makeup_params
        params.require(:makeup).permit(:title, :makeup_description, :avatar, :actors, :release_date, :comments, :rating)
    end

  
end