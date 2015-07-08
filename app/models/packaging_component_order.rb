class PackagingComponentOrder < ActiveRecord::Base
  belongs_to  :project, inverse_of: :packaging_component_order
  belongs_to  :purchase_order, inverse_of: :packaging_component_order, counter_cache: :line_items_count
  belongs_to  :packaging_component, inverse_of: :packaging_component_order
end
