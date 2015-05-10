class Package < ActiveRecord::Base
  has_many  :projects
  has_and_belongs_to_many :packaging_components
  has_and_belongs_to_many :bottles,       association_foreign_key: 'packaging_component_id', join_table: 'packages_packaging_tables'
  has_and_belongs_to_many :back_labels,   association_foreign_key: 'packaging_component_id', join_table: 'packages_packaging_tables'
  has_and_belongs_to_many :front_labels,  association_foreign_key: 'packaging_component_id', join_table: 'packages_packaging_tables'
  has_and_belongs_to_many :corks,         association_foreign_key: 'packaging_component_id', join_table: 'packages_packaging_tables'
  has_and_belongs_to_many :capsules,      association_foreign_key: 'packaging_component_id', join_table: 'packages_packaging_tables'
  has_and_belongs_to_many :screwcaps,     association_foreign_key: 'packaging_component_id', join_table: 'packages_packaging_tables'
  has_and_belongs_to_many :shippers,      association_foreign_key: 'packaging_component_id', join_table: 'packages_packaging_tables'
  
end
