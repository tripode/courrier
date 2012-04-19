module ApplicationHelper
  def mark_required(object, attribute)
    "*" if object.class.validators_on(attribute).map(&:class).include? ActiveModel::Validations::PresenceValidator
  end
  
  #
  # Este metodo es para mostrar mensajes flash al usuario
  # tiene tres tipos, notice, info, warning y error.
  #
  def flash_message
    messages = ""
    [:notice, :info, :warning, :error].each {|type|
      if flash[type]
        messages += "<p class=\"#{type}\">#{flash[type]}</p>"
      end
    }
    render(:inline => messages)
  end
  
end 
