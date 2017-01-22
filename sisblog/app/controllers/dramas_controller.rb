class DramasController < ApplicationController
    
  # GET /drama_index  
  def index
    @dramas = Drama.all
  end
  
  # GET /drama_index/new
  def new
    @drama = Drama.new
  end
  
  def show
    @drama_show = Drama.find(params[:id])
  end
  
  def create
      # Mass assignment of form fields into Contact object
      @drama = Drama.new(drama_params)
      # Save the Contact object to the database
      if @drama.save
          # Store form fields via parameters into local variables
          title = params[:drama][:title]
          description = params[:drama][:description]
          flash[:success] = "Message Sent."
          redirect_to drama_index_path
      else
          # If contact object doesn't save,
          # store errors in flash hash and redirect to new action
          # flash[:danger] = @contact.errors.full_messages.join(", ")
          redirect_to drama_index_path
      end
  end
  
  private
  # To collect data from form, we need to use strong parameters
  # and whitelist the form fields
    def drama_params
        params.require(:drama).permit(:title, :description)
    end

  
end