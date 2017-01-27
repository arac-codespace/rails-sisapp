class RecommendationsController < ApplicationController
  #Breadcrumb display order.
  add_breadcrumb "Inicio", :root_path 
  add_breadcrumb "Recomendaciones", :recomendaciones_path
  add_breadcrumb "Articulos Recomendaciones", :recommendations_path

  
  


  # GET /dramas  
  def index
    @q = Recommendation.ransack(params[:q])
    @recommendations = @q.result(distinct: true)
    @category = params[:cat] #Variable catches query string for categorized views.
    # @category = params[:cat] #Variable catches query string for categorized views.
  end
  
  # GET /dramas/new
  def new
    @recommendation = Recommendation.new
    add_breadcrumb "Add a new entry."
  end
  
  # GET /dramas/:id
  def show
    @recommendation_show = Recommendation.find(params[:id])
     add_breadcrumb "Recommendation"
  end
  
  # GET /dramas/:id/edit
  def edit
    @recommendation = Recommendation.find(params[:id])
    add_breadcrumb "Edit entry."    
  end
  
  # PUT /dramas/:id
  def update
    @recommendation = Recommendation.find(params[:id])
    if @recommendation.update_attributes(recommendation_params)
      flash[:success] = "Profile updated!"
      # Redirect to the drama's profile
      redirect_to recommendation_path(id: params[:id])
    else
      render action: :edit #Don't send, go back to edit action.
    end
  end
  
  # DELETE /dramas/:id
  def destroy
    @recommendation = Recommendation.find(params[:id])
    @recommendation.destroy
    flash.notice= "Profile deleted."
    # Redirect to dramas index
    redirect_to recommendations_path
  end
  
  #POST /dramas
  def create
      # Mass assignment of form fields into Drama object
      @recommendation = Recommendation.new(recommendation_params)
      # Save the Drama object to the database
      if @recommendation.save
        # When the model is saved, have public_activity track this activity and
        # associate it with the create action.
        @recommendation.create_activity :create
        flash[:success] = " Profile created."
        redirect_to recommendations_path 
      else
        flash[:danger] = "Error: Profile not saved."
        redirect_to recommendations_path
      end
  end
  
  private
  # To collect data from form, we need to use strong parameters
  # and whitelist the form fields
    def recommendation_params
        params.require(:recommendation).permit(:title, :category, :recommendation_description, :comments)
    end

  
end