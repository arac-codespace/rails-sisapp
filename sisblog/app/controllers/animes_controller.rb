class AnimesController < ApplicationController
  #Breadcrumb display order.
  add_breadcrumb "Inicio", :root_path 
  add_breadcrumb "Reseñas", :resenas_path
  add_breadcrumb "Indice Anime", :animes_path
  


  # GET /animes  
  def index
    @q = Anime.ransack(params[:q])
    @animes = @q.result(distinct: true)
    # @category = params[:cat] #Variable catches query string for categorized views.
  end
  
  # GET /animes/new
  def new
    @anime = Anime.new
    add_breadcrumb "Añade una nueva entrada!"
  end
  
  # GET /animes/:id
  def show
    @page_url = request.original_url
    @anime_show = Anime.find(params[:id])
     add_breadcrumb "Anime"
  end
  
  # GET /animes/:id/edit
  def edit
    @anime = Anime.find(params[:id])
    add_breadcrumb "Editar articulo"    
  end
  
  # PUT /animes/:id
  def update
    @anime = Anime.find(params[:id])
    if @anime.update_attributes(anime_params)
      flash[:success] = "Articulo Revisado!"
      # Redirect to the anime's profile
      redirect_to anime_path(id: params[:id])
    else
      render action: :edit #Don't send, go back to edit action.
    end
  end
  
  # DELETE /animes/:id
  def destroy
    @anime = Anime.find(params[:id])
    @anime.destroy
    flash.notice= "Articulo eliminado."
    # Redirect to animes index
    redirect_to animes_path
  end
  
  #POST /animes
  def create
      # Mass assignment of form fields into Anime object
      @anime = Anime.new(anime_params)
      # Save the Anime object to the database
      if @anime.save
        # When the model is saved, have public_activity track this activity and
        # associate it with the create action.
        @anime.create_activity :create
        flash[:success] = " Articulo creado!"
        redirect_to animes_path 
      else
        flash[:danger] = "Error: Articulo no se pudo crear."
        redirect_to animes_path
      end
  end
  
  private
  # To collect data from form, we need to use strong parameters
  # and whitelist the form fields
    def anime_params
        params.require(:anime).permit(:title, :anime_description, :avatar, :studios, :release_date, :comments, :rating)
    end

  
end