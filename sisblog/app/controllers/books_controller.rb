class BooksController < ApplicationController
  #Breadcrumb display order.
  add_breadcrumb "Inicio", :root_path 
  add_breadcrumb "Reseñas", :resenas_path
  add_breadcrumb "Indice Libros", :books_path
  


  # GET /books  
  def index
    @q = Book.ransack(params[:q])
    @books = @q.result(distinct: true).paginate(page: params[:page], per_page: 10)
  end
  
  # GET /books/new
  def new
    @book = Book.new
    add_breadcrumb "Añade una nueva entrada!"
  end
  
  # GET /books/:id
  def show
    @book_show = Book.find(params[:id])
    @page_url = request.original_url

    add_breadcrumb "#{@book_show.title}"

  end
  
  # GET /books/:id/edit
  def edit
    @book = Book.find(params[:id])
    @book_id = params[:id]
    
    add_breadcrumb "#{@book.title}", book_path(id: @book_id)
    add_breadcrumb "Editar artículo"    
  end
  
  # PUT /books/:id
  def update
    @book = Book.find(params[:id])
    if @book.update_attributes(book_params)
      flash[:success] = "Artículo Revisado!"
      # Redirect to the book's profile
      redirect_to book_path(id: params[:id])
    else
      render action: :edit #Don't send, go back to edit action.
    end
  end
  
  # DELETE /books/:id
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    flash.notice= "Artículo eliminado."
    # Redirect to books index
    redirect_to books_path
  end
  
  #POST /books
  def create
      # Mass assignment of form fields into Book object
      @book = Book.new(book_params)
      # Save the Book object to the database
      if @book.save
        # When the model is saved, have public_activity track this activity and
        # associate it with the create action.
        @book.create_activity :create
        flash[:success] = " Artículo creado!"
        redirect_to books_path 
      else
        flash[:danger] = "Error: Artículo no se pudo crear."
        redirect_to books_path
      end
  end
  
  private
  # To collect data from form, we need to use strong parameters
  # and whitelist the form fields
    def book_params
        params.require(:book).permit(:title, :book_description, :avatar, :author, :release_date, :comments, :rating)
    end

  
end