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
  has_one     :project, through: :component_requirement
  
  validates_uniqueness_of :component_requirement_id
  
  def total_cost
    price + allocated_overhead
  end
  
  def allocated_overhead
    component_share = price / purchase_order.subtotal
    component_share * purchase_order.overhead
  end
end
