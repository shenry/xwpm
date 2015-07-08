class Can < ActiveRecord::Base
  has_many :component_requirements, as: :packageable
end