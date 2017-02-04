class RecommendationsController < ApplicationController
  #Breadcrumb display order.
  add_breadcrumb "Inicio", :root_path 
  add_breadcrumb "Recomendaciones", :recomendaciones_path
  add_breadcrumb "Indice Recomendaciones", :recommendations_path

  # GET /recommendations  
  def index
    @q = Recommendation.ransack(params[:q])
    @recommendations = @q.result(distinct: true).paginate(page: params[:page], per_page: 10)
    @category = params[:cat] #Variable catches query string for categorized views.
    # @category = params[:cat] #Variable catches query string for categorized views.
  end
  
  # GET /recommendations/new
  def new
    @recommendation = Recommendation.new
    add_breadcrumb "Añade una nueva entrada!"
  end
  
  # GET /recommendations/:id
  def show
    @recommendation_show = Recommendation.find(params[:id])
    @page_url = request.original_url
     add_breadcrumb "Recomendacion"
  end
  
  # GET /recommendations/:id/edit
  def edit
    @recommendation = Recommendation.find(params[:id])
    add_breadcrumb "Editar artículo"    
  end
  
  # PUT /recommendations/:id
  def update
    @recommendation = Recommendation.find(params[:id])
    if @recommendation.update_attributes(recommendation_params)
      flash[:success] = "Artículo Revisado!"
      # Redirect to the recommendation's profile
      redirect_to recommendation_path(id: params[:id])
    else
      render action: :edit #Don't send, go back to edit action.
    end
  end
  
  # DELETE /recommendations/:id
  def destroy
    @recommendation = Recommendation.find(params[:id])
    @recommendation.destroy
    flash.notice= "Artículo eliminado."
    # Redirect to recommendations index
    redirect_to recommendations_path
  end
  
  #POST /recommendations
  def create
      # Mass assignment of form fields into Recommendation object
      @recommendation = Recommendation.new(recommendation_params)
      # Save the Recommendation object to the database
      if @recommendation.save
        # When the model is saved, have public_activity track this activity and
        # associate it with the create action.
        @recommendation.create_activity :create
        flash[:success] = " Artículo creado!"
        redirect_to recommendations_path 
      else
        flash[:danger] = "Error: Artículo no se pudo crear."
        redirect_to recommendations_path
      end
  end
  
  private
  # To collect data from form, we need to use strong parameters
  # and whitelist the form fields
    def recommendation_params
        params.require(:recommendation).permit(:title, :category, :recommendation_description, :comments, :avatar)
    end

  
end