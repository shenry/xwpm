class ComponentRequirement < ActiveRecord::Base
  belongs_to  :project
  belongs_to  :packageable, polymorphic: true, inverse_of: :component_requirements
end
