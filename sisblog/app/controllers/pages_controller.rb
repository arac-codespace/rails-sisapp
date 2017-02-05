class PagesController < ApplicationController
  
  def home
    add_breadcrumb "Inicio", :root_path  
  end
  
  def about
    add_breadcrumb "Inicio", :root_path  
    add_breadcrumb "Sobre Nosotras", :sobre_nosotras_path
  end
  
  def resenas
    # Public_activity collects tracked model information here.
    # The information to be tracked is designated in the new form view file of the specific model!
    @activities = PublicActivity::Activity.order('created_at desc').limit(10)
    # Here I take the public_activity hash, order it and put a condition on it.
    # The idea of the following code is to limit the tracked activity to the pertaining web section.
    # Categories assigned when creating an article...
    @activities_condition = "Drama", "Other", "Movie", "Book","Makeup","FacialProduct","Anime"
    # Assigns entries to activities_by_ctrl as long as they have a trackable_type matiching
    # The conditions stated above.
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