# == Schema Information
#
# Table name: packaging_component_orders
#
#  purchase_order_id        :integer
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  component_requirement_id :integer
#

class PackagingComponentOrder < ActiveRecord::Base
  belongs_to  :purchase_order, inverse_of: :line_items, counter_cache: :line_items_count
  belongs_to  :component_requirement, inverse_of: :packaging_component_order

  def project
    
  end
end
