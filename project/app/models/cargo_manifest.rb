class CargoManifest < ActiveRecord::Base
  has_many :cargo_manifest_details
  belongs_to :city
  belongs_to :employee
end
