class Capsule < ActiveRecord::Base
  has_many    :packages
  belongs_to  :vendor
end
