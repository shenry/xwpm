class Firm < ActiveRecord::Base
  has_many    :projects
  # has_many    :closures,  as: :vendor,   :dependent => :destroy
  # has_many    :bottles,   as: :vendor,   :dependent => :destroy
end
