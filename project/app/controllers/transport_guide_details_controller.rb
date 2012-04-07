class TransportGuideDetailsController < ApplicationController
  def index
 #  puts "Index Transport guide details"
#     @transport_guide_detail = TransportGuideDetail.new
#
#
#    respond_to do |format|
#      format.html # index.html.erb
#      format.json { render json: @transport_guide_detail}
#    end
  end
  def show
    
  end

  def new
#     puts "new Transport guide details"
#    @transport_guide_detail = TransportGuideDetail.new
#
#
#    respond_to do |format|
#      format.html # index.html.erb
#      format.json { render json: @transport_guide_detail}
#    end
  end

  def create
#    puts "create Transport guide details"
#    # @transport_guide = TransportGuide.new(params[:transport_guide])
#
#   # value = @transport_guide.save
#   cont =0;
#    params[:lista].each do |k,v|
#      puts k
#      puts v
#      array = Array.new
#      array =k.split(', ')
#      puts array[1];
#      @transport_guide_detail =TransportGuideDetail.new(
#          "product_type_id"=>v,
#          "amount"=>v,
#          "weight" =>v,
#          "transport_guide_id"=>7
#      )
#      t.integer :transport_guide_id, :null=>false
#      t.integer :amount
#      t.integer :product_type_id, :null=>false
#      #en kilogramos
#      t.decimal :weight
#      @transport_guide_detail.save
#      cont+=1
#    end
#    puts cont
 

  end

  def destroy
    @transport_guide_details = TransportGuideDetail.find(params[:id])
    @transport_guide = TransportGuide.find(@transport_guide_details.transport_guide_id)
    
    @transport_guide_details.destroy

    respond_to do |format|
      format.html { redirect_to edit_transport_guide_url(@transport_guide) }
      format.json { head :no_content }
   end
  end
end
