class MoviesController < ApplicationController
  #Breadcrumb display order.
  add_breadcrumb "Inicio", :root_path 
  add_breadcrumb "Reseñas", :resenas_path
  add_breadcrumb "Indice Movies", :movies_path
  


  # GET /movies 
  def index
    @q = Movie.ransack(params[:q])
    @movies = @q.result(distinct: true)
    @category = params[:cat] #Variable catches query string for categorized views.
  end
  
  # GET /movies/new
  def new
    @movie = Movie.new
    add_breadcrumb "Add a new entry"
  end
  
   # GET /movies/:id
  def show
    @movie_show = Movie.find(params[:id])
     add_breadcrumb "Movie"
  end
  # GET /movies/:id/edit  
  def edit
    @movie = Movie.find(params[:id])
    add_breadcrumb "Edit entry"    
  end
  
  # PUT /movies/:id
  def update
    @movie = Movie.find(params[:id])
    if @movie.update_attributes(movie_params)
      flash[:success] = "Profile updated!"
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
    flash.notice=" Profile deleted."

    redirect_to movies_path
  end
  
  #POST /movies
  def create
      # Mass assignment of form fields into Movie object
      @movie = Movie.new(movie_params)
      # Save the Movie object to the database
      if @movie.save
        flash[:success] = "Profile created."
        redirect_to movies_path 
      else
        flash[:danger] = "Error: profile not saved."
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