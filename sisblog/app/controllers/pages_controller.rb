class PagesController < ApplicationController
  def home
    add_breadcrumb "Inicio", :root_path  
  end
  
  def about
    add_breadcrumb "Inicio", :root_path  
    add_breadcrumb "Sobre Nosotras", :sobre_nosotras_path
  end
  
  def resenas
    # public_activity collects tracked information here.
    # The information to be tracked is determined in the new form file!
    @activities = PublicActivity::Activity.order('created_at desc').limit(10)
    # Here I take the public_activity hash, order it and put a condition on it.
    # The idea is to limit the tracked activity to the pertaining web section.
    @activities_condition = "Drama", "Other", "Movie", "Book","Makeup","FacialProduct","Anime"
    @activities_by_ctrl = @activities.where({ trackable_type: [@activities_condition] })

    add_breadcrumb "Inicio", :root_path  
    add_breadcrumb "Reseñas", :resenas_path
  end
  
  def cuidado_personal
    
    @activities = PublicActivity::Activity.order('created_at desc').limit(10)
    @activities_condition = "Care"
    @activities_by_ctrl = @activities.where({ trackable_type: [@activities_condition] })    
    
    add_breadcrumb "Inicio", :root_path  
    add_breadcrumb "Cuidado Personal", :cuidado_personal_path
  end
  
  def recomendaciones
    
    @activities = PublicActivity::Activity.order('created_at desc').limit(10)
    @activities_condition = "Recommendation"
   
    @activities_by_ctrl = @activities.where({ trackable_type: [@activities_condition] })        
    add_breadcrumb "Inicio", :root_path  
    add_breadcrumb "Recomendaciones", :recomendaciones_path
  end
  
end