class Closure < PackagingComponent
  belongs_to  :vendor
  has_many    :packages
end