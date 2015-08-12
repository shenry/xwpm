# == Schema Information
#
# Table name: component_requirements
#
#  id               :integer          not null, primary key
#  project_id       :integer
#  packageable_id   :integer
#  packageable_type :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  ancestry         :string
#

class ComponentRequirement < ActiveRecord::Base
  before_destroy :check_if_purchase_order
  
  belongs_to  :project
  belongs_to  :packageable, polymorphic: true
  has_one     :packaging_component_order
  has_one     :purchase_order, through: :packaging_component_order
  
  has_ancestry orphan_strategy: :adopt
  
  # accepts_nested_attributes_for :packageable
  
  validates :project_id, :packageable_id, :packageable_type, presence: true
  
  def cost
    packaging_component_order.total_cost
  end
  
  def purchase_order?
    !purchase_order.nil?
  end
  
  private
  
  def check_if_purchase_order
    return true unless purchase_order?
    errors.add :base, "This component has been ordered on PO##{purchase_order.number}"
    false
  end
end
