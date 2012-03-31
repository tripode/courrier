class City < ActiveRecord::Base
  has_many :receivers
  has_many :retire_notes
  has_many :transport_guides

  #lista todo las Ciudad guardadas en la bd
  def self.get_list_cities
    all.collect { |city| [city.name, city.id]  }
  end
end
