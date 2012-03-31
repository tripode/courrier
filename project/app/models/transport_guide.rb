class TransportGuide < ActiveRecord::Base
  belongs_to :customer
  belongs_to :foreign_company
  belongs_to :employee
  belongs_to :service_type
  belongs_to :transport_guide_state
  belongs_to :payment_method
  belongs_to :city
  has_many :transport_guide_details#, :foreign_key => [:id, :transport_guide_id]

  #GT guia de tranporte
  
  #lista todos los estado de GT en un select
  def get_list_state
    TransportGuideState.get_list_guide_state
  end

  #lista todos las ciudades disponibles en un select
  def get_list_cities
    City.get_list_cities
  end

  #lista todos los tipo de servicios disponibles en un select
  def get_list_service_types
    ServiceType.get_list_service_types
  end

  #lista todos las formas de pagos disponibles en un select
  def get_list_payments_methods
    PaymentMethod.get_list_payment_methods
  end

  #formato de fecha
  def format_date
    created_at= Date.today
    created_at.strftime("%d-%m-%Y") if created_at
    

  end

end
