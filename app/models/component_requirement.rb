class ComponentRequirement < ActiveRecord::Base
  belongs_to  :project
  belongs_to  :packageable, polymorphic: true
end
