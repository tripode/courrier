class TransportGuideDetailsController < ApplicationController
  
  
  #
  # Antes de hacer cualquier cosa con este controler,
  # se verifica si hay permiso para el usuario logueado
  #
  before_filter :check_permissions
  skip_before_filter :require_no_authentication
  #
  # Llama a este metodo y verifica los permisos que tiene para Employee
  #
  def check_permissions
    authorize! :create, TransportGuideDetail
  end
  
  
  def index

  end
  def show
    
  end

  def new

  end

  def create

  end

  #delete
  def destroy

  end

  #post
  def delete_detail_product
    cont = 0
    index=0
    tgd=@@transport_guide_details;
    @@transport_guide_details=Array.new
    tgd.each do |detail|
      
      if(params[:destroy].to_i!= cont)
        puts detail.product_type.description
        @@transport_guide_details.insert(index, detail)
        index+=1
        
      end
      cont+=1
    end  
    @transport_guide_details=@@transport_guide_details
    respond_to do |format|
      format.js
    end
  end

  @@index_product=0
  #  @@transport_guide_details=Array.new
  #post
  def add_detail_product
    puts "entro en add_Detail_product"

    @transport_guide_detail=TransportGuideDetail.new
    @transport_guide_detail.amount=params[:amount]
    @transport_guide_detail.weight=params[:weight]
    @transport_guide_detail.product_type_id=params[:product_type_id]

    @@transport_guide_details=Array.new if params[:cant_product].to_i==0
    @@transport_guide_details.insert(params[:cant_product].to_i, @transport_guide_detail)
   
    @transport_guide_details=@@transport_guide_details
    respond_to do |format|
      format.js
    end

  end

end
