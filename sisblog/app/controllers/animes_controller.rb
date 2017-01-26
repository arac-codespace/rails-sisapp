class AnimesController < ApplicationController
  #Breadcrumb display order.
  add_breadcrumb "Inicio", :root_path 
  add_breadcrumb "Reseñas", :resenas_path
  add_breadcrumb "Indice Anime", :animes_path
  


  # GET /dramas  
  def index
    @q = Anime.ransack(params[:q])
    @animes = @q.result(distinct: true)
    # @category = params[:cat] #Variable catches query string for categorized views.
  end
  
  # GET /dramas/new
  def new
    @anime = Anime.new
    add_breadcrumb "Add a new entry."
  end
  
  # GET /dramas/:id
  def show
    @anime_show = Anime.find(params[:id])
     add_breadcrumb "Anime"
  end
  
  # GET /dramas/:id/edit
  def edit
    @anime = Anime.find(params[:id])
    add_breadcrumb "Edit entry."    
  end
  
  # PUT /dramas/:id
  def update
    @anime = Anime.find(params[:id])
    if @anime.update_attributes(anime_params)
      flash[:success] = "Profile updated!"
      # Redirect to the drama's profile
      redirect_to anime_path(id: params[:id])
    else
      render action: :edit #Don't send, go back to edit action.
    end
  end
  
  # DELETE /dramas/:id
  def destroy
    @anime = Anime.find(params[:id])
    @anime.destroy
    flash.notice= "Profile deleted."
    # Redirect to dramas index
    redirect_to animes_path
  end
  
  #POST /dramas
  def create
      # Mass assignment of form fields into Drama object
      @anime = Anime.new(anime_params)
      # Save the Drama object to the database
      if @anime.save
        # When the model is saved, have public_activity track this activity and
        # associate it with the create action.
        @anime.create_activity :create
        flash[:success] = " Profile created."
        redirect_to animes_path 
      else
        flash[:danger] = "Error: Profile not saved."
        redirect_to animes_path
      end
  end
  
  private
  # To collect data from form, we need to use strong parameters
  # and whitelist the form fields
    def anime_params
        params.require(:anime).permit(:title, :anime_description, :avatar, :actors, :release_date, :comments, :rating)
    end

  
end