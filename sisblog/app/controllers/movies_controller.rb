class MoviesController < ApplicationController
  #Breadcrumb display order.
  add_breadcrumb "Inicio", :root_path 
  add_breadcrumb "Reseñas", :resenas_path
  add_breadcrumb "Indice Peliculas", :movies_path
  


  # GET /movies 
  def index
    @q = Movie.ransack(params[:q])
    @movies = @q.result(distinct: true)
    @category = params[:cat] #Variable catches query string for categorized views.
  end
  
  # GET /movies/new
  def new
    @movie = Movie.new
    add_breadcrumb "Añade una nueva entrada!"
  end
  
   # GET /movies/:id
  def show
    @movie_show = Movie.find(params[:id])
    @page_url = request.original_url
     add_breadcrumb "Pelicula"
  end
  # GET /movies/:id/edit  
  def edit
    @movie = Movie.find(params[:id])
    add_breadcrumb "Editar articulo"    
  end
  
  # PUT /movies/:id
  def update
    @movie = Movie.find(params[:id])
    if @movie.update_attributes(movie_params)
      flash[:success] = "Articulo Revisado!"
      # Redirect to the movie's profile
      redirect_to movie_path(id: params[:id])
    else
      render action: :edit #Don't send, go back to edit action.
    end
  end
  
    # DELETE /movies/:id
  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash.notice= "Articulo eliminado."

    redirect_to movies_path
  end
  
  #POST /movies
  def create
      # Mass assignment of form fields into Movie object
      @movie = Movie.new(movie_params)
      # Save the Movie object to the database
      if @movie.save
        # When the model is saved, have public_activity track this activity and
        # associate it with the create action.
        @movie.create_activity :create
        flash[:success] = " Articulo creado!"
        redirect_to movies_path 
      else
        flash[:danger] = "Error: Articulo no se pudo crear."
        redirect_to movies_path
      end
  end
  
  private
  # To collect data from form, we need to use strong parameters
  # and whitelist the form fields
    def movie_params
        params.require(:movie).permit(:title, :movie_description, :avatar, :category, :actors, :release_date, :comments, :rating)
    end

  
end