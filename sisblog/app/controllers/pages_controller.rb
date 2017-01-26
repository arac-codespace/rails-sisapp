class PagesController < ApplicationController
 
  
  def home
  end
  
  def about
    add_breadcrumb "Inicio", :root_path  
    add_breadcrumb "Sobre Nosotras", :sobre_nosotras_path
  end
  
  def resenas
    # public_activity collects tracked information here.
    # The information to be tracked is determined in the model controller file!
    @activities = PublicActivity::Activity.order('created_at desc').limit(10)

    add_breadcrumb "Inicio", :root_path  
    add_breadcrumb "Reseñas", :resenas_path
  end
end