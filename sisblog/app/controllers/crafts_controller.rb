class CraftsController < ApplicationController
  #Breadcrumb display order.
  add_breadcrumb "Inicio", :root_path 
  add_breadcrumb "Indice Craft", :crafts_path
  


  # GET /dramas  
  def index
    @q = Craft.ransack(params[:q])
    @crafts = @q.result(distinct: true)
    # @category = params[:cat] #Variable catches query string for categorized views.
  end
  
  # GET /dramas/new
  def new
    @craft = Craft.new
    add_breadcrumb "Add a new entry."
  end
  
  # GET /dramas/:id
  def show
    @craft_show = Craft.find(params[:id])
     add_breadcrumb "Craft"
  end
  
  # GET /dramas/:id/edit
  def edit
    @craft = Craft.find(params[:id])
    add_breadcrumb "Edit entry."    
  end
  
  # PUT /dramas/:id
  def update
    @craft = Craft.find(params[:id])
    if @craft.update_attributes(craft_params)
      flash[:success] = "Profile updated!"
      # Redirect to the drama's profile
      redirect_to craft_path(id: params[:id])
    else
      render action: :edit #Don't send, go back to edit action.
    end
  end
  
  # DELETE /dramas/:id
  def destroy
    @craft = Craft.find(params[:id])
    @craft.destroy
    flash.notice= "Profile deleted."
    # Redirect to dramas index
    redirect_to crafts_path
  end
  
  #POST /dramas
  def create
      # Mass assignment of form fields into Drama object
      @craft = Craft.new(craft_params)
      # Save the Drama object to the database
      if @craft.save
        # When the model is saved, have public_activity track this activity and
        # associate it with the create action.
        @craft.create_activity :create
        flash[:success] = " Profile created."
        redirect_to crafts_path 
      else
        flash[:danger] = "Error: Profile not saved."
        redirect_to crafts_path
      end
  end
  
  private
  # To collect data from form, we need to use strong parameters
  # and whitelist the form fields
    def craft_params
        params.require(:craft).permit(:title, :craft_description, :comments)
    end

  
end