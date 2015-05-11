class Package < ActiveRecord::Base
  has_many  :projects
  has_and_belongs_to_many :packaging_components
  has_one :bottle
  
  # belongs_to :bottle
  # has_one :back_label,   association_foreign_key: 'packaging_component_id', join_table: 'packages_packaging_tables'
  # has_one :front_label,  association_foreign_key: 'packaging_component_id', join_table: 'packages_packaging_tables'
  # has_one :cork,         association_foreign_key: 'packaging_component_id', join_table: 'packages_packaging_tables'
  # has_one :capsule,      association_foreign_key: 'packaging_component_id', join_table: 'packages_packaging_tables'
  # has_one :screwcap,     association_foreign_key: 'packaging_component_id', join_table: 'packages_packaging_tables'
  # has_one :shipper,      association_foreign_key: 'packaging_component_id', join_table: 'packages_packaging_tables'
  
end
