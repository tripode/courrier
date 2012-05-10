class Area < ActiveRecord::Base
  has_many :routing_sheets, :dependent => :destroy
  belongs_to :city
  
  def getAreas
    Area.all.collect{|a|[a.area_name, a.id]}
  end
end
