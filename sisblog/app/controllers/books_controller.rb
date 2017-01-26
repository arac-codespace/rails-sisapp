class BooksController < ApplicationController
  #Breadcrumb display order.
  add_breadcrumb "Inicio", :root_path 
  add_breadcrumb "Reseñas", :resenas_path
  add_breadcrumb "Indice Book", :books_path
  


  # GET /dramas  
  def index
    @q = Book.ransack(params[:q])
    @books = @q.result(distinct: true)
    # @category = params[:cat] #Variable catches query string for categorized views.
  end
  
  # GET /dramas/new
  def new
    @book = Book.new
    add_breadcrumb "Add a new entry."
  end
  
  # GET /dramas/:id
  def show
    @book_show = Book.find(params[:id])
     add_breadcrumb "Book"
  end
  
  # GET /dramas/:id/edit
  def edit
    @book = Book.find(params[:id])
    add_breadcrumb "Edit entry."    
  end
  
  # PUT /dramas/:id
  def update
    @book = Book.find(params[:id])
    if @book.update_attributes(book_params)
      flash[:success] = "Profile updated!"
      # Redirect to the drama's profile
      redirect_to book_path(id: params[:id])
    else
      render action: :edit #Don't send, go back to edit action.
    end
  end
  
  # DELETE /dramas/:id
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    flash.notice= "Profile deleted."
    # Redirect to dramas index
    redirect_to books_path
  end
  
  #POST /dramas
  def create
      # Mass assignment of form fields into Drama object
      @book = Book.new(book_params)
      # Save the Drama object to the database
      if @book.save
        # When the model is saved, have public_activity track this activity and
        # associate it with the create action.
        @book.create_activity :create
        flash[:success] = " Profile created."
        redirect_to books_path 
      else
        flash[:danger] = "Error: Profile not saved."
        redirect_to books_path
      end
  end
  
  private
  # To collect data from form, we need to use strong parameters
  # and whitelist the form fields
    def book_params
        params.require(:book).permit(:title, :book_description, :avatar, :actors, :release_date, :comments, :rating)
    end

  
end