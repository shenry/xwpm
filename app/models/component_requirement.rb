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
  
  belongs_to  :project
  belongs_to  :packageable, polymorphic: true
  has_one     :event, class_name: "ComponentEvent", as: :actionable, dependent: :destroy
  
  has_ancestry orphan_strategy: :adopt
  
  validates :project_id, :packageable_id, :packageable_type, presence: true
  
  def event_action
    "Deplete"
  end
  
  def cost
    packaging_component_order.total_cost
  end
  
  def required_quantity
    num = project.packageable_units
    (num += packageable.fudge_factor(num)).to_i
  end
  
  def waiting_for_delivery?
    packageable.quantity < required_quantity
  end
end
