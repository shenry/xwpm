class BackLabel < PackagingComponent
  belongs_to  :vendor
  has_many    :packages
end