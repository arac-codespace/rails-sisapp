class PagesController < ApplicationController
 
  
  def home
  end
  
  def about
    add_breadcrumb "Inicio", :root_path  
    add_breadcrumb "Sobre Nosotras", :sobre_nosotras_path
  end
  
  def resenas
    # @q = Drama.ransack(params[:q])
    # @dramas = @q.result(distinct: true)
    
    add_breadcrumb "Inicio", :root_path  
    add_breadcrumb "Reseñas", :resenas_path
  end
end