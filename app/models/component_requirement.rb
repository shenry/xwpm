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
#

class ComponentRequirement < ActiveRecord::Base
  belongs_to  :project
  belongs_to  :packageable, polymorphic: true
  has_one     :packaging_component_order, dependent: :destroy
  has_one     :purchase_order, through: :packaging_component_order
  
  # accepts_nested_attributes_for :packageable
  
  validates :project_id, :packageable_id, :packageable_type, presence: true
  
  def cost
    packaging_component_order.total_cost
  end
end
